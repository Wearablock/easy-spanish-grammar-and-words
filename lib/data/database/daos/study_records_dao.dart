import 'package:drift/drift.dart';
import '../../../core/config/constants.dart';
import '../../../core/utils/debug_utils.dart';
import '../app_database.dart';
import '../tables/study_records.dart';

part 'study_records_dao.g.dart';

@DriftAccessor(tables: [StudyRecords])
class StudyRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$StudyRecordsDaoMixin {
  StudyRecordsDao(super.db);

  // ── 기본 CRUD ──

  Future<List<StudyRecord>> getAllRecords() => select(studyRecords).get();

  Future<StudyRecord?> getByQuestionId(String questionId) {
    return (select(studyRecords)
          ..where((t) => t.questionId.equals(questionId)))
        .getSingleOrNull();
  }

  Future<void> upsertRecord(StudyRecordsCompanion record) {
    return into(studyRecords).insertOnConflictUpdate(record);
  }

  Future<int> deleteByQuestionId(String questionId) {
    return (delete(studyRecords)
          ..where((t) => t.questionId.equals(questionId)))
        .go();
  }

  Future<int> deleteAll() => delete(studyRecords).go();

  // ── Topic/Level별 조회 ──

  Future<List<StudyRecord>> getByTopicId(String topicId) {
    return (select(studyRecords)
          ..where((t) => t.topicId.equals(topicId)))
        .get();
  }

  Future<List<StudyRecord>> getByLevelId(String levelId) {
    return (select(studyRecords)
          ..where((t) => t.levelId.equals(levelId)))
        .get();
  }

  // ── 레벨별 조회 (스페이스드 리피티션) ──

  Future<List<StudyRecord>> getByLevel(int level) {
    return (select(studyRecords)..where((t) => t.level.equals(level))).get();
  }

  Future<List<StudyRecord>> getMasteredQuestions() {
    return (select(studyRecords)
          ..where((t) => t.level.equals(StudyConstants.masteryLevel)))
        .get();
  }

  // ── 복습 대상 문제 조회 ──

  Future<List<StudyRecord>> getReviewQuestions({int limit = 100}) {
    final now = DebugUtils.now;
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (select(studyRecords)
          ..where((t) =>
              t.level.isSmallerThanValue(StudyConstants.masteryLevel) &
              t.nextReviewAt.isSmallerOrEqualValue(now) &
              t.lastStudiedAt.isSmallerThanValue(startOfDay))
          ..orderBy([
            (t) => OrderingTerm(expression: t.level),
            (t) => OrderingTerm(expression: t.nextReviewAt),
          ])
          ..limit(limit))
        .get();
  }

  // ── 학습 결과 업데이트 ──

  Future<void> markCorrect(String questionId) async {
    final record = await getByQuestionId(questionId);
    if (record == null) return;

    final now = DebugUtils.now;
    final newLevel =
        (record.level + 1).clamp(0, StudyConstants.masteryLevel);
    final nextReview = _calculateNextReview(newLevel);

    await (update(studyRecords)
          ..where((t) => t.questionId.equals(questionId)))
        .write(StudyRecordsCompanion(
      level: Value(newLevel),
      correctCount: Value(record.correctCount + 1),
      lastStudiedAt: Value(now),
      nextReviewAt: Value(nextReview),
      updatedAt: Value(now),
    ));
  }

  Future<void> markWrong(String questionId) async {
    final record = await getByQuestionId(questionId);
    if (record == null) return;

    final now = DebugUtils.now;
    final tomorrowMidnight =
        DateTime(now.year, now.month, now.day).add(const Duration(days: 1));

    await (update(studyRecords)
          ..where((t) => t.questionId.equals(questionId)))
        .write(StudyRecordsCompanion(
      level: const Value(0),
      wrongCount: Value(record.wrongCount + 1),
      lastStudiedAt: Value(now),
      nextReviewAt: Value(tomorrowMidnight),
      updatedAt: Value(now),
    ));
  }

  DateTime _calculateNextReview(int level) {
    final now = DebugUtils.now;
    final days = StudyConstants
        .reviewIntervals[level.clamp(0, StudyConstants.masteryLevel)];
    return DateTime(now.year, now.month, now.day).add(Duration(days: days));
  }

  // ── 통계 쿼리 ──

  Future<int> getTotalStudiedCount() async {
    final count = studyRecords.id.count();
    final query = selectOnly(studyRecords)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  Future<Map<String, double>> getTopicProgress() async {
    final records = await getAllRecords();
    final topicGroups = <String, List<StudyRecord>>{};

    for (final record in records) {
      topicGroups.putIfAbsent(record.topicId, () => []).add(record);
    }

    return topicGroups.map((topicId, records) {
      final masteredCount = records.where((r) => r.level >= 3).length;
      return MapEntry(topicId, masteredCount / records.length);
    });
  }

  Future<Map<String, double>> getLevelProgress() async {
    final records = await getAllRecords();
    final levelGroups = <String, List<StudyRecord>>{};

    for (final record in records) {
      levelGroups.putIfAbsent(record.levelId, () => []).add(record);
    }

    return levelGroups.map((levelId, records) {
      final masteredCount = records.where((r) => r.level >= 3).length;
      return MapEntry(levelId, masteredCount / records.length);
    });
  }

  Future<double> getOverallAccuracy() async {
    final records = await getAllRecords();
    if (records.isEmpty) return 0.0;

    int totalCorrect = 0;
    int totalAttempts = 0;

    for (final record in records) {
      totalCorrect += record.correctCount;
      totalAttempts += record.correctCount + record.wrongCount;
    }

    if (totalAttempts == 0) return 0.0;
    return totalCorrect / totalAttempts;
  }

  Future<Map<int, int>> getLevelDistribution() async {
    final records = await getAllRecords();
    final distribution = <int, int>{};

    for (int i = 0; i <= StudyConstants.masteryLevel; i++) {
      distribution[i] = 0;
    }

    for (final record in records) {
      distribution[record.level] =
          (distribution[record.level] ?? 0) + 1;
    }

    return distribution;
  }

  Future<int> getTodayStudiedCount() async {
    final today = DebugUtils.now;
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = select(studyRecords)
      ..where((t) =>
          t.lastStudiedAt.isBiggerOrEqualValue(startOfDay) &
          t.lastStudiedAt.isSmallerThanValue(endOfDay));

    final records = await query.get();
    return records.length;
  }

  Future<int> getTodayStudiedTopicCount() async {
    final today = DebugUtils.now;
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = select(studyRecords)
      ..where((t) =>
          t.lastStudiedAt.isBiggerOrEqualValue(startOfDay) &
          t.lastStudiedAt.isSmallerThanValue(endOfDay));

    final records = await query.get();
    final uniqueTopics = records.map((r) => r.topicId).toSet();
    return uniqueTopics.length;
  }
}
