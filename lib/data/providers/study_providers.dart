import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../core/utils/question_selector.dart';
import '../../services/study_service.dart';
import '../models/study_session.dart';
import 'database_providers.dart';
import 'question_providers.dart';

// ============================================================
// Core Providers
// ============================================================

/// QuestionSelector 제공
final questionSelectorProvider = Provider<QuestionSelector>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final questionRepo = ref.watch(questionRepositoryProvider);
  return QuestionSelector(db, questionRepo);
});

/// StudyService 제공
final studyServiceProvider = Provider<StudyService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final questionRepo = ref.watch(questionRepositoryProvider);
  return StudyService(db, questionRepo);
});

// ============================================================
// Session Providers
// ============================================================

/// 현재 학습 세션
final currentSessionProvider = StateProvider<StudySession?>((ref) => null);

/// 세션 생성 (토픽 수 기준)
final createSessionProvider = FutureProvider.family<StudySession, int>(
  (ref, topicCount) async {
    final studyService = ref.watch(studyServiceProvider);
    return studyService.createDailySession(topicCount: topicCount);
  },
);

// ============================================================
// Summary & Stats Providers
// ============================================================

/// 앱 통계 통합 데이터 (병렬 로딩)
class AppStats {
  final TodaySummary todaySummary;
  final double overallProgress;
  final Map<String, LevelProgress> levelProgress;

  const AppStats({
    required this.todaySummary,
    required this.overallProgress,
    required this.levelProgress,
  });
}

/// 앱 통계 통합 Provider
final appStatsProvider = FutureProvider<AppStats>((ref) async {
  final studyService = ref.watch(studyServiceProvider);

  final results = await Future.wait([
    studyService.getTodaySummary(),
    studyService.getOverallProgress(),
    studyService.getLevelProgress(),
  ]);

  return AppStats(
    todaySummary: results[0] as TodaySummary,
    overallProgress: results[1] as double,
    levelProgress: results[2] as Map<String, LevelProgress>,
  );
});

/// 오늘의 학습 요약 (appStatsProvider에서 파생)
final todaySummaryProvider = FutureProvider<TodaySummary>((ref) async {
  final appStats = await ref.watch(appStatsProvider.future);
  return appStats.todaySummary;
});

/// 전체 진행률 (appStatsProvider에서 파생)
final overallProgressProvider = FutureProvider<double>((ref) async {
  final appStats = await ref.watch(appStatsProvider.future);
  return appStats.overallProgress;
});

/// 레벨별 진행률 (appStatsProvider에서 파생)
final levelProgressProvider =
    FutureProvider<Map<String, LevelProgress>>((ref) async {
  final appStats = await ref.watch(appStatsProvider.future);
  return appStats.levelProgress;
});

/// 복습 필요 문제 수
final reviewDueCountProvider = FutureProvider<int>((ref) async {
  final selector = ref.watch(questionSelectorProvider);
  return selector.getReviewDueCount();
});

/// 학습 가능한 총 문제 수
final availableQuestionCountProvider = FutureProvider<int>((ref) async {
  final selector = ref.watch(questionSelectorProvider);
  return selector.getAvailableQuestionCount();
});

// ============================================================
// Allocation Preview Providers
// ============================================================

/// 일일 토픽 문제 선택 미리보기
final dailySelectionPreviewProvider =
    FutureProvider.family<DailyQuestionSelection, int>(
  (ref, topicCount) async {
    final selector = ref.watch(questionSelectorProvider);
    return selector.selectDailyTopicQuestions(topicCount: topicCount);
  },
);

/// 남은 학습 토픽 수
final remainingTopicCountProvider = FutureProvider<int>((ref) async {
  final selector = ref.watch(questionSelectorProvider);
  return selector.getRemainingTopicCount();
});

// ============================================================
// Statistics Providers
// ============================================================

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
