/// 세션 단계
enum SessionPhase {
  wrongReview,
  spacedReview,
  newLearning,
  completed,
}

/// 세션 내 현재 아이템 유형
enum SessionItemType {
  theory,
  quiz,
}

/// 세션 아이템 (이론 또는 퀴즈)
class SessionItem {
  final SessionItemType type;
  final SessionPhase phase;
  final String? topicId;
  final String? questionId;

  const SessionItem({
    required this.type,
    required this.phase,
    this.topicId,
    this.questionId,
  });

  bool get isTheory => type == SessionItemType.theory;
  bool get isQuiz => type == SessionItemType.quiz;

  @override
  String toString() {
    if (isTheory) {
      return 'SessionItem(theory, topic: $topicId)';
    }
    return 'SessionItem(quiz, question: $questionId, phase: $phase)';
  }
}

/// 퀴즈 결과
class QuizResult {
  final String questionId;
  final bool isCorrect;
  final String? selectedAnswer;
  final DateTime answeredAt;

  const QuizResult({
    required this.questionId,
    required this.isCorrect,
    this.selectedAnswer,
    required this.answeredAt,
  });

  @override
  String toString() {
    return 'QuizResult(question: $questionId, correct: $isCorrect)';
  }
}

/// 학습 세션
class StudySession {
  final String id;
  final DateTime startedAt;
  DateTime? completedAt;

  final List<String> wrongReviewIds;
  final List<String> spacedReviewIds;
  final List<String> newQuestionIds;
  final List<String> newTopicIds;

  final List<SessionItem> items;

  int _currentIndex;
  SessionPhase _currentPhase;

  final List<QuizResult> results;

  /// Topic별 신규 문제 매핑
  final Map<String, List<String>> newQuestionsByTopic;

  StudySession({
    required this.id,
    required this.startedAt,
    required this.wrongReviewIds,
    required this.spacedReviewIds,
    required this.newQuestionIds,
    required this.newTopicIds,
    required this.newQuestionsByTopic,
  })  : items = _buildItems(
          wrongReviewIds,
          spacedReviewIds,
          newTopicIds,
          newQuestionsByTopic,
        ),
        _currentIndex = 0,
        _currentPhase = _determineInitialPhase(
          wrongReviewIds,
          spacedReviewIds,
          newQuestionIds,
        ),
        results = [];

  /// 세션 아이템 목록 생성
  static List<SessionItem> _buildItems(
    List<String> wrongReviewIds,
    List<String> spacedReviewIds,
    List<String> newTopicIds,
    Map<String, List<String>> newQuestionsByTopic,
  ) {
    final items = <SessionItem>[];

    // 1. 오답 복습 (퀴즈만)
    for (final qId in wrongReviewIds) {
      items.add(SessionItem(
        type: SessionItemType.quiz,
        phase: SessionPhase.wrongReview,
        questionId: qId,
      ));
    }

    // 2. 망각곡선 복습 (퀴즈만)
    for (final qId in spacedReviewIds) {
      items.add(SessionItem(
        type: SessionItemType.quiz,
        phase: SessionPhase.spacedReview,
        questionId: qId,
      ));
    }

    // 3. 신규 학습 (Topic별: 이론 -> 해당 Topic 퀴즈)
    for (final topicId in newTopicIds) {
      items.add(SessionItem(
        type: SessionItemType.theory,
        phase: SessionPhase.newLearning,
        topicId: topicId,
      ));

      final topicQuestions = newQuestionsByTopic[topicId] ?? [];
      for (final qId in topicQuestions) {
        items.add(SessionItem(
          type: SessionItemType.quiz,
          phase: SessionPhase.newLearning,
          questionId: qId,
        ));
      }
    }

    return items;
  }

  static SessionPhase _determineInitialPhase(
    List<String> wrongReviewIds,
    List<String> spacedReviewIds,
    List<String> newQuestionIds,
  ) {
    if (wrongReviewIds.isNotEmpty) return SessionPhase.wrongReview;
    if (spacedReviewIds.isNotEmpty) return SessionPhase.spacedReview;
    if (newQuestionIds.isNotEmpty) return SessionPhase.newLearning;
    return SessionPhase.completed;
  }

  // ── Getters ──

  int get currentIndex => _currentIndex;
  SessionPhase get currentPhase => _currentPhase;

  SessionItem? get currentItem {
    if (_currentIndex >= items.length) return null;
    return items[_currentIndex];
  }

  bool get isCompleted => _currentPhase == SessionPhase.completed;
  bool get isEmpty => items.isEmpty;
  int get totalItems => items.length;
  int get totalQuizzes => items.where((i) => i.isQuiz).length;
  int get totalTheories => items.where((i) => i.isTheory).length;
  int get completedItems => _currentIndex;

  double get progress {
    if (items.isEmpty) return 1.0;
    return _currentIndex / items.length;
  }

  int get correctCount => results.where((r) => r.isCorrect).length;
  int get wrongCount => results.where((r) => !r.isCorrect).length;

  double get accuracy {
    if (results.isEmpty) return 0.0;
    return correctCount / results.length;
  }

  int get wrongReviewQuizCount => wrongReviewIds.length;
  int get spacedReviewQuizCount => spacedReviewIds.length;
  int get newLearningQuizCount => newQuestionIds.length;

  int get wrongReviewCompletedCount =>
      results.where((r) => wrongReviewIds.contains(r.questionId)).length;
  int get spacedReviewCompletedCount =>
      results.where((r) => spacedReviewIds.contains(r.questionId)).length;
  int get newLearningCompletedCount =>
      results.where((r) => newQuestionIds.contains(r.questionId)).length;

  // ── Actions ──

  void moveNext() {
    if (_currentIndex < items.length) {
      _currentIndex++;
    }

    if (_currentIndex >= items.length) {
      _currentPhase = SessionPhase.completed;
      completedAt = DateTime.now();
    } else {
      _currentPhase = items[_currentIndex].phase;
    }
  }

  void recordQuizResult({
    required String questionId,
    required bool isCorrect,
    String? selectedAnswer,
  }) {
    results.add(QuizResult(
      questionId: questionId,
      isCorrect: isCorrect,
      selectedAnswer: selectedAnswer,
      answeredAt: DateTime.now(),
    ));
  }

  void complete() {
    _currentPhase = SessionPhase.completed;
    completedAt = DateTime.now();
  }

  int get durationSeconds {
    final end = completedAt ?? DateTime.now();
    return end.difference(startedAt).inSeconds;
  }

  String get durationFormatted {
    final seconds = durationSeconds;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes > 0) {
      return '$minutes분 $remainingSeconds초';
    }
    return '$remainingSeconds초';
  }

  // ── Serialization ──

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'started_at': startedAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'wrong_review_ids': wrongReviewIds,
      'spaced_review_ids': spacedReviewIds,
      'new_question_ids': newQuestionIds,
      'new_topic_ids': newTopicIds,
      'new_questions_by_topic': newQuestionsByTopic,
      'current_index': _currentIndex,
      'results': results
          .map((r) => {
                'question_id': r.questionId,
                'is_correct': r.isCorrect,
                'selected_answer': r.selectedAnswer,
                'answered_at': r.answeredAt.toIso8601String(),
              })
          .toList(),
    };
  }

  @override
  String toString() {
    return 'StudySession(id: $id, phase: $_currentPhase, progress: ${(progress * 100).toStringAsFixed(1)}%)';
  }
}
