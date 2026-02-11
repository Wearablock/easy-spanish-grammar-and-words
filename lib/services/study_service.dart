import 'package:drift/drift.dart';
import '../core/config/constants.dart';
import '../core/utils/debug_utils.dart';
import '../core/utils/error_handler.dart';
import '../core/utils/question_selector.dart';
import '../data/database/app_database.dart';
import '../data/models/question.dart';
import '../data/models/study_session.dart';
import '../data/repositories/question_repository.dart';

class StudyService {
  final AppDatabase _db;
  final QuestionRepository _questionRepository;
  late final QuestionSelector _questionSelector;

  StudyService(this._db, this._questionRepository) {
    _questionSelector = QuestionSelector(_db, _questionRepository);
  }

  /// QuestionSelector 접근자
  QuestionSelector get questionSelector => _questionSelector;

  /// 오늘의 학습 세션 생성 (토픽 기준)
  /// [topicCount]: 학습할 토픽 수 (기본값 1)
  Future<StudySession> createDailySession({int topicCount = 1}) async {
    final selection = await _questionSelector.selectDailyTopicQuestions(
      topicCount: topicCount,
    );

    return StudySession(
      id: DebugUtils.now.millisecondsSinceEpoch.toString(),
      startedAt: DebugUtils.now,
      wrongReviewIds: selection.wrongReviewIds,
      spacedReviewIds: selection.spacedReviewIds,
      newQuestionIds: selection.newQuestionIds,
      newTopicIds: selection.newTopicIds,
      newQuestionsByTopic: selection.newQuestionsByTopic,
    );
  }

  /// 단일 토픽 학습 세션 생성
  Future<StudySession> createSingleTopicSession() async {
    return createDailySession(topicCount: 1);
  }

  /// 복수 토픽 학습 세션 생성
  Future<StudySession> createMultiTopicSession({
    required int topicCount,
  }) async {
    return createDailySession(topicCount: topicCount);
  }

  /// 복습 전용 세션 생성
  Future<StudySession> createReviewSession() async {
    final selection = await _questionSelector.selectReviewQuestions();

    return StudySession(
      id: DebugUtils.now.millisecondsSinceEpoch.toString(),
      startedAt: DebugUtils.now,
      wrongReviewIds: selection.wrongReviewIds,
      spacedReviewIds: selection.spacedReviewIds,
      newQuestionIds: [],
      newTopicIds: [],
      newQuestionsByTopic: {},
    );
  }

  /// 오답노트 재도전 세션 생성 (특정 문제 ID 기반)
  StudySession createWrongAnswersRetrySession(List<String> questionIds) {
    return StudySession(
      id: DebugUtils.now.millisecondsSinceEpoch.toString(),
      startedAt: DebugUtils.now,
      wrongReviewIds: questionIds,
      spacedReviewIds: [],
      newQuestionIds: [],
      newTopicIds: [],
      newQuestionsByTopic: {},
    );
  }

  /// 복습 필요 여부 확인
  Future<bool> hasReviewDue() async {
    final count = await _questionSelector.getReviewDueCount();
    return count > 0;
  }

  /// 정답 처리
  Future<void> processCorrectAnswer({
    required StudySession session,
    required Question question,
  }) async {
    // 1. 세션에 결과 기록
    session.recordQuizResult(
      questionId: question.id,
      isCorrect: true,
    );

    // 2. 기존 학습 기록 조회
    final existingRecord =
        await _db.studyRecordsDao.getByQuestionId(question.id);

    final levelId =
        QuestionRepository.extractLevelFromTopicId(question.topicId);

    if (existingRecord == null) {
      // 3a. 신규 문제: 새 레코드 생성 (레벨 1)
      final now = DebugUtils.now;
      final tomorrowMidnight =
          DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
      await _db.studyRecordsDao.upsertRecord(StudyRecordsCompanion.insert(
        questionId: question.id,
        topicId: question.topicId,
        levelId: levelId,
        level: const Value(1),
        correctCount: const Value(1),
        lastStudiedAt: Value(now),
        nextReviewAt: Value(tomorrowMidnight),
      ));
    } else {
      // 3b. 기존 문제: 레벨 업, 다음 복습일 계산
      await _db.studyRecordsDao.markCorrect(question.id);
    }

    // 4. 오답 풀에서 정답 처리 (있으면)
    await _db.wrongAnswersDao.markCorrected(question.id);

    // 5. 일일 통계 업데이트
    final isNew = existingRecord == null;
    await _db.dailyStatsDao.recordCorrectAnswer(isNewQuestion: isNew);
  }

  /// 오답 처리
  Future<void> processWrongAnswer({
    required StudySession session,
    required Question question,
    required String selectedAnswer,
  }) async {
    // 1. 세션에 결과 기록
    session.recordQuizResult(
      questionId: question.id,
      isCorrect: false,
      selectedAnswer: selectedAnswer,
    );

    // 2. 기존 학습 기록 조회
    final existingRecord =
        await _db.studyRecordsDao.getByQuestionId(question.id);

    final levelId =
        QuestionRepository.extractLevelFromTopicId(question.topicId);

    if (existingRecord == null) {
      // 3a. 신규 문제: 레벨 0으로 생성, 내일 자정부터 복습
      final now = DebugUtils.now;
      final tomorrowMidnight =
          DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
      await _db.studyRecordsDao.upsertRecord(StudyRecordsCompanion.insert(
        questionId: question.id,
        topicId: question.topicId,
        levelId: levelId,
        level: const Value(0),
        wrongCount: const Value(1),
        lastStudiedAt: Value(now),
        nextReviewAt: Value(tomorrowMidnight),
      ));
    } else {
      // 3b. 기존 문제: 레벨 다운
      await _db.studyRecordsDao.markWrong(question.id);
    }

    // 4. 오답 풀에 추가
    await _db.wrongAnswersDao.recordWrongAnswer(
      questionId: question.id,
      topicId: question.topicId,
      levelId: levelId,
      selectedAnswer: selectedAnswer,
    );

    // 5. 일일 통계 업데이트
    final isNew = existingRecord == null;
    await _db.dailyStatsDao.recordWrongAnswer(isNewQuestion: isNew);
  }

  /// 세션 완료 처리
  Future<void> completeSession(StudySession session) async {
    session.complete();
    await _db.dailyStatsDao.addStudyTime(session.durationSeconds);
  }

  /// 오늘의 학습 요약 조회
  Future<TodaySummary> getTodaySummary() async {
    return ErrorHandler.runSafe(
      context: 'getTodaySummary',
      fallback: const TodaySummary(
        questionsStudied: 0,
        correctAnswers: 0,
        streak: 0,
        reviewDueCount: 0,
        totalQuestions: 0,
        masteredCount: 0,
      ),
      action: () async {
        final results = await Future.wait([
          _db.dailyStatsDao.getToday(),
          _db.dailyStatsDao.getCurrentStreak(),
          _questionSelector.getReviewDueCount(),
          _questionRepository.getTotalQuestionCount(),
          _db.studyRecordsDao.getMasteredQuestions(),
          _getNextTopicInfo(),
          _db.userSettingsDao.getDailyGoal(),
          _db.studyRecordsDao.getTodayStudiedTopicCount(),
          _db.studyRecordsDao.getTotalStudiedCount(),
        ]);

        final todayStats = results[0] as DailyStat?;
        final streak = results[1] as int;
        final reviewDueCount = results[2] as int;
        final totalQuestionCount = results[3] as int;
        final masteredRecords = results[4] as List;
        final nextTopicInfo = results[5] as _NextTopicInfo;
        final dailyGoalTopics = results[6] as int;
        final todayStudiedTopics = results[7] as int;
        final studiedCount = results[8] as int;

        return TodaySummary(
          questionsStudied: todayStats?.questionsStudied ?? 0,
          correctAnswers: todayStats?.correctAnswers ?? 0,
          streak: streak,
          reviewDueCount: reviewDueCount,
          totalQuestions: totalQuestionCount,
          masteredCount: masteredRecords.length,
          studiedCount: studiedCount,
          nextTopicId: nextTopicInfo.topicId,
          nextTopicQuestionCount: nextTopicInfo.questionCount,
          allTopicsCompleted: nextTopicInfo.allCompleted,
          dailyGoalTopics: dailyGoalTopics,
          todayStudiedTopics: todayStudiedTopics,
        );
      },
    );
  }

  /// 다음 학습할 토픽 정보 조회
  Future<_NextTopicInfo> _getNextTopicInfo() async {
    return ErrorHandler.runSafe(
      context: '_getNextTopicInfo',
      fallback: const _NextTopicInfo(
        topicId: null,
        questionCount: 0,
        allCompleted: false,
      ),
      action: () async {
        final allStudiedIds = (await _db.studyRecordsDao.getAllRecords())
            .map((r) => r.questionId)
            .toSet();
        final allQuestionMeta = await _questionRepository.loadMeta();

        // 학습하지 않은 첫 번째 토픽 찾기
        String? nextTopicId;
        for (final meta in allQuestionMeta) {
          if (!allStudiedIds.contains(meta.id)) {
            nextTopicId = meta.topicId;
            break;
          }
        }

        // 모든 토픽 완료
        if (nextTopicId == null) {
          return const _NextTopicInfo(
            topicId: null,
            questionCount: 0,
            allCompleted: true,
          );
        }

        // 해당 토픽의 문제 수 계산
        final topicQuestionCount =
            allQuestionMeta.where((m) => m.topicId == nextTopicId).length;

        return _NextTopicInfo(
          topicId: nextTopicId,
          questionCount: topicQuestionCount,
          allCompleted: false,
        );
      },
    );
  }

  /// 전체 진행률 조회
  Future<double> getOverallProgress() async {
    return ErrorHandler.runSafe(
      context: 'getOverallProgress',
      fallback: 0.0,
      action: () async {
        final totalQuestionCount =
            await _questionRepository.getTotalQuestionCount();
        if (totalQuestionCount == 0) return 0.0;

        final masteredRecords =
            await _db.studyRecordsDao.getMasteredQuestions();
        return masteredRecords.length / totalQuestionCount;
      },
    );
  }

  /// 레벨별 진행률 조회
  Future<Map<String, LevelProgress>> getLevelProgress() async {
    return ErrorHandler.runSafe(
      context: 'getLevelProgress',
      fallback: <String, LevelProgress>{},
      action: () async {
        final results = await Future.wait([
          _db.studyRecordsDao.getAllRecords(),
          _questionRepository.loadMeta(),
        ]);

        final allRecords = results[0] as List<StudyRecord>;
        final allQuestionMeta = results[1] as List<QuestionMeta>;

        // 레벨별 총 문제 수 계산
        final levelQuestionCounts = <String, int>{};
        for (final meta in allQuestionMeta) {
          final levelId =
              QuestionRepository.extractLevelFromTopicId(meta.topicId);
          levelQuestionCounts[levelId] =
              (levelQuestionCounts[levelId] ?? 0) + 1;
        }

        // 레벨별 학습/완전습득 문제 수 계산
        final levelStudiedCounts = <String, int>{};
        final levelMasteredCounts = <String, int>{};
        for (final record in allRecords) {
          levelStudiedCounts[record.levelId] =
              (levelStudiedCounts[record.levelId] ?? 0) + 1;
          if (record.level >= StudyConstants.masteryLevel) {
            levelMasteredCounts[record.levelId] =
                (levelMasteredCounts[record.levelId] ?? 0) + 1;
          }
        }

        final result = <String, LevelProgress>{};
        for (final levelId in levelQuestionCounts.keys) {
          result[levelId] = LevelProgress(
            levelId: levelId,
            totalQuestions: levelQuestionCounts[levelId]!,
            studiedQuestions: levelStudiedCounts[levelId] ?? 0,
            masteredQuestions: levelMasteredCounts[levelId] ?? 0,
          );
        }
        return result;
      },
    );
  }
}

/// 오늘의 학습 요약
class TodaySummary {
  final int questionsStudied;
  final int correctAnswers;
  final int streak;
  final int reviewDueCount;
  final int totalQuestions;
  final int masteredCount;

  /// 1회 이상 학습한 문제 수
  final int studiedCount;

  /// 다음 학습할 토픽 정보
  final String? nextTopicId;
  final int nextTopicQuestionCount;

  /// 모든 토픽 완료 여부
  final bool allTopicsCompleted;

  /// 일일 목표 (토픽 수)
  final int dailyGoalTopics;

  /// 오늘 학습한 토픽 수
  final int todayStudiedTopics;

  const TodaySummary({
    required this.questionsStudied,
    required this.correctAnswers,
    required this.streak,
    required this.reviewDueCount,
    required this.totalQuestions,
    required this.masteredCount,
    this.studiedCount = 0,
    this.nextTopicId,
    this.nextTopicQuestionCount = 0,
    this.allTopicsCompleted = false,
    this.dailyGoalTopics = 1,
    this.todayStudiedTopics = 0,
  });

  /// 오늘의 정답률
  double get todayAccuracy {
    if (questionsStudied == 0) return 0.0;
    return correctAnswers / questionsStudied;
  }

  /// 전체 진행률 (완전 습득 비율)
  double get overallProgress {
    if (totalQuestions == 0) return 0.0;
    return masteredCount / totalQuestions;
  }

  /// 학습 진행률 (1회 이상 학습 비율)
  double get studiedProgress {
    if (totalQuestions == 0) return 0.0;
    return studiedCount / totalQuestions;
  }

  /// 오늘의 학습 진행률 (일일 목표 대비)
  double get todayProgress {
    if (dailyGoalTopics == 0) return 0.0;
    return (todayStudiedTopics / dailyGoalTopics).clamp(0.0, 1.0);
  }

  /// 오늘 목표 달성 여부
  bool get isTodayGoalAchieved => todayStudiedTopics >= dailyGoalTopics;

  /// 학습할 토픽이 있는지
  bool get hasNextTopic => nextTopicId != null && !allTopicsCompleted;

  @override
  String toString() {
    return 'TodaySummary(studied: $questionsStudied, streak: $streak, mastered: $masteredCount/$totalQuestions, todayTopics: $todayStudiedTopics/$dailyGoalTopics, nextTopic: $nextTopicId)';
  }
}

/// 레벨별 진행률
class LevelProgress {
  final String levelId;
  final int totalQuestions;
  final int studiedQuestions;
  final int masteredQuestions;

  const LevelProgress({
    required this.levelId,
    required this.totalQuestions,
    required this.studiedQuestions,
    required this.masteredQuestions,
  });

  /// 학습 진행률
  double get studiedProgress {
    if (totalQuestions == 0) return 0.0;
    return studiedQuestions / totalQuestions;
  }

  /// 완전 습득 진행률
  double get masteredProgress {
    if (totalQuestions == 0) return 0.0;
    return masteredQuestions / totalQuestions;
  }

  /// 남은 문제 수
  int get remainingQuestions => totalQuestions - studiedQuestions;

  @override
  String toString() {
    return 'LevelProgress($levelId: studied $studiedQuestions/$totalQuestions, mastered $masteredQuestions)';
  }
}

/// 다음 학습할 토픽 정보 (내부 사용)
class _NextTopicInfo {
  final String? topicId;
  final int questionCount;
  final bool allCompleted;

  const _NextTopicInfo({
    required this.topicId,
    required this.questionCount,
    required this.allCompleted,
  });
}
