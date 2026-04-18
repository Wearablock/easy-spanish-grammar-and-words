import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/constants.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../data/database/app_database.dart';
import 'speaking_models.dart';

/// 말하기 복습 대기 카드 수.
final speakingReviewDueCountProvider = FutureProvider<int>((ref) async {
  return AppDatabase().speakingProgressDao.getReviewDueCount();
});

/// 자동 세션 미리보기 — 복습 대기/새 카드 개수.
class SpeakingAutoSessionPreview {
  final int dueCount;
  final int newCount;
  const SpeakingAutoSessionPreview({
    required this.dueCount,
    required this.newCount,
  });

  int get total => dueCount + newCount;
  bool get isEmpty => total == 0;
}

/// 자동 세션 구성기 — 복습 대기 카드 + 아직 학습 안 한 새 카드를
/// 섞어서 N개짜리 세션을 만든다.
///
/// 우선순위: 복습 대기를 모두(최대 N) 먼저 담고, 남는 자리를 새 카드로 채운다.
/// 전부 마스터해서 비어있으면 빈 리스트 반환 (호출부에서 메시지 처리).
class SpeakingAutoSession {
  SpeakingAutoSession._();

  /// 현재 상태에서 세션에 넣을 후보 수를 계산.
  static Future<SpeakingAutoSessionPreview> preview() async {
    final classification = await _classify();
    return SpeakingAutoSessionPreview(
      dueCount: classification.reviewDue.length,
      newCount: classification.newCards.length,
    );
  }

  /// 세션 N개 카드 구성.
  static Future<List<SpeakingCard>> build({required int size}) async {
    final rng = Random();
    final classification = await _classify();

    final due = [...classification.reviewDue]..shuffle(rng);
    final fresh = [...classification.newCards]..shuffle(rng);

    final picked = <SpeakingCard>[];
    picked.addAll(due.take(size));
    final remaining = size - picked.length;
    if (remaining > 0) {
      picked.addAll(fresh.take(remaining));
    }
    picked.shuffle(rng);
    return picked;
  }

  static Future<_Classification> _classify() async {
    final seeds = await SpeakingSeedLoader.loadAll();
    final allCards = <SpeakingCard>[];
    for (final s in seeds) {
      allCards.addAll(s.cards);
    }

    final progressById = <String, dynamic>{};
    final progress = await AppDatabase().speakingProgressDao.getAll();
    for (final p in progress) {
      progressById[p.cardId] = p;
    }

    final now = DebugUtils.now;
    final due = <SpeakingCard>[];
    final fresh = <SpeakingCard>[];
    for (final c in allCards) {
      final p = progressById[c.id];
      if (p == null) {
        fresh.add(c);
        continue;
      }
      final nextReviewAt = p.nextReviewAt as DateTime?;
      final level = p.level as int;
      if (level >= StudyConstants.masteryLevel) continue;
      if (nextReviewAt != null && !nextReviewAt.isAfter(now)) {
        due.add(c);
      }
    }
    return _Classification(reviewDue: due, newCards: fresh);
  }
}

class _Classification {
  final List<SpeakingCard> reviewDue;
  final List<SpeakingCard> newCards;
  _Classification({required this.reviewDue, required this.newCards});
}
