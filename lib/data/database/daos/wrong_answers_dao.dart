import 'package:drift/drift.dart';
import '../../../core/utils/debug_utils.dart';
import '../app_database.dart';
import '../tables/wrong_answers.dart';

part 'wrong_answers_dao.g.dart';

@DriftAccessor(tables: [WrongAnswers])
class WrongAnswersDao extends DatabaseAccessor<AppDatabase>
    with _$WrongAnswersDaoMixin {
  WrongAnswersDao(super.db);

  // ── 기본 CRUD ──

  Future<List<WrongAnswer>> getAllWrongAnswers() =>
      select(wrongAnswers).get();

  Future<WrongAnswer?> getByQuestionId(String questionId) {
    return (select(wrongAnswers)
          ..where((t) => t.questionId.equals(questionId)))
        .getSingleOrNull();
  }

  Future<void> upsertWrongAnswer(WrongAnswersCompanion record) {
    return into(wrongAnswers).insertOnConflictUpdate(record);
  }

  Future<int> deleteByQuestionId(String questionId) {
    return (delete(wrongAnswers)
          ..where((t) => t.questionId.equals(questionId)))
        .go();
  }

  Future<int> deleteAll() => delete(wrongAnswers).go();

  // ── 오답 기록 관리 ──

  Future<void> recordWrongAnswer({
    required String questionId,
    required String topicId,
    required String levelId,
    required String selectedAnswer,
  }) async {
    final existing = await getByQuestionId(questionId);
    final now = DebugUtils.now;

    if (existing == null) {
      await upsertWrongAnswer(WrongAnswersCompanion.insert(
        questionId: questionId,
        topicId: topicId,
        levelId: levelId,
        wrongCount: const Value(1),
        lastWrongAnswer: Value(selectedAnswer),
        wrongAt: now,
      ));
    } else {
      await upsertWrongAnswer(WrongAnswersCompanion(
        id: Value(existing.id),
        questionId: Value(questionId),
        topicId: Value(topicId),
        levelId: Value(levelId),
        wrongCount: Value(existing.wrongCount + 1),
        lastWrongAnswer: Value(selectedAnswer),
        wrongAt: Value(now),
        correctedAt: const Value(null),
        updatedAt: Value(now),
      ));
    }
  }

  Future<void> markCorrected(String questionId) async {
    final now = DebugUtils.now;
    await (update(wrongAnswers)
          ..where((t) => t.questionId.equals(questionId)))
        .write(WrongAnswersCompanion(
      correctedAt: Value(now),
      updatedAt: Value(now),
    ));
  }

  Future<void> removeFromWrongPool(String questionId) async {
    await deleteByQuestionId(questionId);
  }

  // ── 오답 조회 (복습용) ──

  Future<List<WrongAnswer>> getUncorrectedWrongAnswers({int? limit}) {
    final today = DebugUtils.now;
    final startOfDay = DateTime(today.year, today.month, today.day);

    final query = select(wrongAnswers)
      ..where((t) =>
          t.correctedAt.isNull() &
          t.updatedAt.isSmallerThanValue(startOfDay))
      ..orderBy([
        (t) => OrderingTerm.desc(t.wrongCount),
        (t) => OrderingTerm.desc(t.wrongAt),
      ]);

    if (limit != null) {
      query.limit(limit);
    }

    return query.get();
  }

  Future<List<WrongAnswer>> getRecentWrongAnswers({int limit = 10}) {
    return (select(wrongAnswers)
          ..orderBy([(t) => OrderingTerm.desc(t.wrongAt)])
          ..limit(limit))
        .get();
  }

  Future<List<WrongAnswer>> getMostWrongAnswers({int limit = 10}) {
    return (select(wrongAnswers)
          ..orderBy([(t) => OrderingTerm.desc(t.wrongCount)])
          ..limit(limit))
        .get();
  }

  Future<List<WrongAnswer>> getCorrectedWrongAnswers() {
    return (select(wrongAnswers)
          ..where((t) => t.correctedAt.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.correctedAt)]))
        .get();
  }

  // ── Topic/Level별 조회 ──

  Future<List<WrongAnswer>> getByTopicId(String topicId) {
    return (select(wrongAnswers)
          ..where((t) => t.topicId.equals(topicId))
          ..orderBy([(t) => OrderingTerm.desc(t.wrongCount)]))
        .get();
  }

  Future<List<WrongAnswer>> getByLevelId(String levelId) {
    return (select(wrongAnswers)
          ..where((t) => t.levelId.equals(levelId))
          ..orderBy([(t) => OrderingTerm.desc(t.wrongCount)]))
        .get();
  }

  // ── 통계 ──

  Future<int> getTotalWrongCount() async {
    final count = wrongAnswers.id.count();
    final query = selectOnly(wrongAnswers)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  Future<int> getUncorrectedCount() async {
    final today = DebugUtils.now;
    final startOfDay = DateTime(today.year, today.month, today.day);

    final query = select(wrongAnswers)
      ..where((t) =>
          t.correctedAt.isNull() &
          t.updatedAt.isSmallerThanValue(startOfDay));
    final results = await query.get();
    return results.length;
  }

  Future<Map<String, int>> getWrongCountByTopic() async {
    final all = await getAllWrongAnswers();
    final result = <String, int>{};

    for (final item in all) {
      result[item.topicId] = (result[item.topicId] ?? 0) + 1;
    }

    return result;
  }

  Future<Map<String, int>> getWrongCountByLevel() async {
    final all = await getAllWrongAnswers();
    final result = <String, int>{};

    for (final item in all) {
      result[item.levelId] = (result[item.levelId] ?? 0) + 1;
    }

    return result;
  }

  Future<List<MapEntry<String, int>>> getTopWrongTopics(
      {int limit = 5}) async {
    final byTopic = await getWrongCountByTopic();
    final sorted = byTopic.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(limit).toList();
  }

  // ── Stream (실시간 감지) ──

  Stream<List<WrongAnswer>> watchUncorrectedWrongAnswers() {
    return (select(wrongAnswers)
          ..where((t) => t.correctedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm.desc(t.wrongCount),
            (t) => OrderingTerm.desc(t.wrongAt),
          ]))
        .watch();
  }

  Stream<int> watchWrongCount() {
    return select(wrongAnswers).watch().map((list) => list.length);
  }
}
