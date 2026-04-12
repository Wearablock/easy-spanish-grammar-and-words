import 'package:drift/drift.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/debug_utils.dart';
import '../app_database.dart';
import '../tables/speaking_progress.dart';

part 'speaking_progress_dao.g.dart';

@DriftAccessor(tables: [SpeakingProgress])
class SpeakingProgressDao extends DatabaseAccessor<AppDatabase>
    with _$SpeakingProgressDaoMixin {
  SpeakingProgressDao(super.db);

  // ── 조회 ──────────────────────────────────────────────

  Future<SpeakingProgressEntry?> getByCardId(String cardId) {
    return (select(speakingProgress)
          ..where((t) => t.cardId.equals(cardId)))
        .getSingleOrNull();
  }

  Future<List<SpeakingProgressEntry>> getAll() =>
      select(speakingProgress).get();

  /// 복습 대기 카드 — `nextReviewAt <= now` AND `level < masteryLevel`
  Future<List<SpeakingProgressEntry>> getReviewDue({int limit = 50}) {
    final now = DebugUtils.now;
    return (select(speakingProgress)
          ..where((t) =>
              t.nextReviewAt.isSmallerOrEqualValue(now) &
              t.level.isSmallerThanValue(StudyConstants.masteryLevel))
          ..orderBy([
            (t) => OrderingTerm(expression: t.level),
            (t) => OrderingTerm(expression: t.nextReviewAt),
          ])
          ..limit(limit))
        .get();
  }

  /// 복습 대기 카드 수 — 홈 알림용
  Future<int> getReviewDueCount() async {
    final due = await getReviewDue(limit: 1000);
    return due.length;
  }

  Future<int> getMasteredCount() async {
    final count = speakingProgress.cardId.count();
    final query = selectOnly(speakingProgress)
      ..addColumns([count])
      ..where(speakingProgress.level.equals(StudyConstants.masteryLevel));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  // ── 업데이트 ───────────────────────────────────────────

  /// 통과 (≥0.8) 시 호출 — level +1, 다음 복습 시각 계산.
  Future<void> markPass({
    required String cardId,
    required String seedId,
  }) async {
    final now = DebugUtils.now;
    final existing = await getByCardId(cardId);
    final newLevel =
        ((existing?.level ?? 0) + 1).clamp(0, StudyConstants.masteryLevel);
    final nextReview = _calculateNextReview(newLevel);

    await into(speakingProgress).insertOnConflictUpdate(
      SpeakingProgressCompanion(
        cardId: Value(cardId),
        seedId: Value(seedId),
        level: Value(newLevel),
        passCount: Value((existing?.passCount ?? 0) + 1),
        failCount: Value(existing?.failCount ?? 0),
        lastStudiedAt: Value(now),
        nextReviewAt: Value(nextReview),
        updatedAt: Value(now),
      ),
    );
  }

  /// 미달 (<0.8) 시 호출 — level 0 리셋, 내일 복습.
  Future<void> markFail({
    required String cardId,
    required String seedId,
  }) async {
    final now = DebugUtils.now;
    final existing = await getByCardId(cardId);
    final tomorrow =
        DateTime(now.year, now.month, now.day).add(const Duration(days: 1));

    await into(speakingProgress).insertOnConflictUpdate(
      SpeakingProgressCompanion(
        cardId: Value(cardId),
        seedId: Value(seedId),
        level: const Value(0),
        passCount: Value(existing?.passCount ?? 0),
        failCount: Value((existing?.failCount ?? 0) + 1),
        lastStudiedAt: Value(now),
        nextReviewAt: Value(tomorrow),
        updatedAt: Value(now),
      ),
    );
  }

  /// 정확도(0~1)를 받아 자동으로 pass/fail 분기.
  Future<void> updateFromAccuracy({
    required String cardId,
    required String seedId,
    required double accuracy,
  }) async {
    if (accuracy >= 0.8) {
      await markPass(cardId: cardId, seedId: seedId);
    } else {
      await markFail(cardId: cardId, seedId: seedId);
    }
  }

  Future<int> deleteAll() => delete(speakingProgress).go();

  DateTime _calculateNextReview(int level) {
    final now = DebugUtils.now;
    final days = StudyConstants
        .reviewIntervals[level.clamp(0, StudyConstants.masteryLevel)];
    return DateTime(now.year, now.month, now.day).add(Duration(days: days));
  }
}
