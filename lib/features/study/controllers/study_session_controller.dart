import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../data/models/study_session.dart';
import '../../../data/models/question.dart';
import '../../../data/providers/premium_provider.dart';
import '../../../data/providers/study_providers.dart';
import '../../../data/providers/question_providers.dart';
import '../../../data/providers/topic_providers.dart';
import '../../../data/providers/database_providers.dart';
import '../../../services/ad_service.dart';

enum StudySessionStatus {
  initial,
  loading,
  inProgress,
  completed,
  error,
}

class StudySessionState {
  final StudySessionStatus status;
  final StudySession? session;
  final Question? currentQuestion;
  final String? errorMessage;

  const StudySessionState({
    this.status = StudySessionStatus.initial,
    this.session,
    this.currentQuestion,
    this.errorMessage,
  });

  StudySessionState copyWith({
    StudySessionStatus? status,
    StudySession? session,
    Question? currentQuestion,
    String? errorMessage,
  }) {
    return StudySessionState(
      status: status ?? this.status,
      session: session ?? this.session,
      currentQuestion: currentQuestion,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  SessionItem? get currentItem => session?.currentItem;
  bool get isTheory => currentItem?.isTheory ?? false;
  bool get isQuiz => currentItem?.isQuiz ?? false;
  double get progress => session?.progress ?? 0.0;
  int get currentIndex => (session?.currentIndex ?? 0) + 1;
  int get totalItems => session?.totalItems ?? 0;
  SessionPhase get currentPhase =>
      session?.currentPhase ?? SessionPhase.completed;
}

class StudySessionController extends StateNotifier<StudySessionState> {
  final Ref _ref;

  StudySessionController(this._ref) : super(const StudySessionState());

  /// 세션 시작 (사용자 설정 토픽 수)
  Future<void> startSession() async {
    state = state.copyWith(status: StudySessionStatus.loading);
    try {
      final studyService = _ref.read(studyServiceProvider);
      final userSettingsDao = _ref.read(userSettingsDaoProvider);
      final topicCount = await userSettingsDao.getDailyGoal();

      final session = await studyService.createDailySession(
        topicCount: topicCount,
      );

      if (session.isEmpty) {
        state = state.copyWith(
          status: StudySessionStatus.completed,
          session: session,
        );
        return;
      }

      state = state.copyWith(
        status: StudySessionStatus.inProgress,
        session: session,
      );
      await _loadCurrentQuestion();
    } catch (e) {
      state = state.copyWith(
        status: StudySessionStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// 복습 세션 시작
  Future<void> startReviewSession() async {
    state = state.copyWith(status: StudySessionStatus.loading);
    try {
      final studyService = _ref.read(studyServiceProvider);
      final session = await studyService.createReviewSession();

      if (session.isEmpty) {
        state = state.copyWith(
          status: StudySessionStatus.completed,
          session: session,
        );
        return;
      }

      state = state.copyWith(
        status: StudySessionStatus.inProgress,
        session: session,
      );
      await _loadCurrentQuestion();
    } catch (e) {
      state = state.copyWith(
        status: StudySessionStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// 오답노트 재도전 세션 시작
  Future<void> startWrongAnswersSession(List<String> questionIds) async {
    state = state.copyWith(status: StudySessionStatus.loading);
    try {
      final studyService = _ref.read(studyServiceProvider);
      final session =
          studyService.createWrongAnswersRetrySession(questionIds);

      if (session.isEmpty) {
        state = state.copyWith(
          status: StudySessionStatus.completed,
          session: session,
        );
        return;
      }

      state = state.copyWith(
        status: StudySessionStatus.inProgress,
        session: session,
      );
      await _loadCurrentQuestion();
    } catch (e) {
      state = state.copyWith(
        status: StudySessionStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// 현재 퀴즈 문제 로드
  Future<void> _loadCurrentQuestion() async {
    final item = state.currentItem;
    if (item == null || !item.isQuiz) {
      state = state.copyWith(currentQuestion: null);
      return;
    }
    final questionRepository = _ref.read(questionRepositoryProvider);
    final locale = _ref.read(currentLocaleProvider);
    final question = await questionRepository.getQuestionById(
      item.questionId!,
      locale,
    );
    state = state.copyWith(currentQuestion: question);
  }

  /// 이론 학습 완료
  Future<void> completeTheory() async {
    final session = state.session;
    if (session == null) return;

    // 이론 → 퀴즈 전환 시 전면 광고
    final isPremium = _ref.read(isPremiumProvider);
    if (!isPremium) {
      await AdService().showInterstitialAd();
    }

    session.moveNext();

    if (session.isCompleted) {
      await _completeSession();
    } else {
      await _loadCurrentQuestion();
      state = StudySessionState(
        status: StudySessionStatus.inProgress,
        session: session,
        currentQuestion: state.currentQuestion,
      );
    }
  }

  /// 퀴즈 정답 처리
  Future<void> answerCorrect() async {
    final session = state.session;
    final question = state.currentQuestion;
    if (session == null || question == null) return;

    final studyService = _ref.read(studyServiceProvider);
    await studyService.processCorrectAnswer(
      session: session,
      question: question,
    );
    _invalidateProgressProviders();
  }

  /// 퀴즈 오답 처리
  Future<void> answerWrong(String selectedAnswer) async {
    final session = state.session;
    final question = state.currentQuestion;
    if (session == null || question == null) return;

    final studyService = _ref.read(studyServiceProvider);
    await studyService.processWrongAnswer(
      session: session,
      question: question,
      selectedAnswer: selectedAnswer,
    );
    _invalidateProgressProviders();
  }

  /// 다음 문제로 이동
  Future<void> moveNext() async {
    final session = state.session;
    if (session == null) return;

    session.moveNext();
    if (session.isCompleted) {
      await _completeSession();
    } else {
      await _loadCurrentQuestion();
      state = StudySessionState(
        status: StudySessionStatus.inProgress,
        session: session,
        currentQuestion: state.currentQuestion,
      );
    }
  }

  /// 세션 완료 처리
  Future<void> _completeSession() async {
    final session = state.session;
    if (session == null) return;

    final studyService = _ref.read(studyServiceProvider);
    await studyService.completeSession(session);

    // 세션 완료 시 전면 광고
    final isPremium = _ref.read(isPremiumProvider);
    if (!isPremium) {
      await AdService().showInterstitialAd();
    }

    _invalidateProgressProviders();

    state = state.copyWith(
      status: StudySessionStatus.completed,
      session: session,
    );
  }

  /// providers 무효화
  void _invalidateProgressProviders() {
    _ref.invalidate(appStatsProvider);
    _ref.invalidate(levelDistributionProvider);
    _ref.invalidate(wrongAnswersWithQuestionsProvider);
  }

  /// 세션 중단
  void cancelSession() {
    state = const StudySessionState();
  }
}

/// Provider 정의
final studySessionControllerProvider =
    StateNotifierProvider<StudySessionController, StudySessionState>((ref) {
  return StudySessionController(ref);
});
