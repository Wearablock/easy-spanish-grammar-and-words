import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/study_session.dart';
import 'database_providers.dart';

// Phase 3에서 QuestionSelector, StudyService 구현 후 완성
// 여기서는 기본 세션 관리 Provider만 정의

/// 현재 학습 세션 (StateProvider로 관리)
final currentSessionProvider =
    StateProvider<StudySession?>((ref) => null);

/// 레벨 분포 통계
final levelDistributionProvider =
    FutureProvider<Map<int, int>>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return db.studyRecordsDao.getLevelDistribution();
});

/// 전체 통계 요약 (스트릭 포함)
final overallSummaryProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return db.dailyStatsDao.getOverallSummary();
});
