/// 문제 유형 (스페인어 학습 특화)
enum QuestionType {
  translation,
  fillBlank,
  conjugation,
  meaning,
  context,
  sentenceOrder,
  listening,
  ;

  /// JSON snake_case -> enum (unknown -> meaning fallback)
  static QuestionType fromString(String? value) {
    if (value == null) return QuestionType.meaning;
    const mapping = {
      'translation': QuestionType.translation,
      'fill_blank': QuestionType.fillBlank,
      'conjugation': QuestionType.conjugation,
      'meaning': QuestionType.meaning,
      'context': QuestionType.context,
      'sentence_order': QuestionType.sentenceOrder,
      'listening': QuestionType.listening,
    };
    return mapping[value] ?? QuestionType.meaning;
  }

  /// enum -> JSON snake_case
  String toJsonString() {
    const mapping = {
      QuestionType.translation: 'translation',
      QuestionType.fillBlank: 'fill_blank',
      QuestionType.conjugation: 'conjugation',
      QuestionType.meaning: 'meaning',
      QuestionType.context: 'context',
      QuestionType.sentenceOrder: 'sentence_order',
      QuestionType.listening: 'listening',
    };
    return mapping[this] ?? 'meaning';
  }
}

/// 번역 방향 (translation 유형 전용)
enum TranslationDirection {
  koToEs,
  esToKo,
  ;

  static TranslationDirection? fromString(String? value) {
    const mapping = {
      'ko_to_es': TranslationDirection.koToEs,
      'es_to_ko': TranslationDirection.esToKo,
    };
    return value != null ? mapping[value] : null;
  }

  String toJsonString() {
    const mapping = {
      TranslationDirection.koToEs: 'ko_to_es',
      TranslationDirection.esToKo: 'es_to_ko',
    };
    return mapping[this] ?? 'ko_to_es';
  }
}

/// 문제 메타데이터 (구조 정보, 언어 독립적)
///
/// JSON 예시 (questions/meta/grammar_a1.json):
/// {
///   "id": "q_gram_a1_01_001",
///   "topic_id": "ch_gram_a1_01",
///   "order": 1,
///   "difficulty": 1,
///   "type": "fill_blank",
///   "translation_dir": null
/// }
class QuestionMeta {
  final String id;
  final String topicId;
  final int order;
  final int difficulty;
  final QuestionType type;
  final TranslationDirection? translationDir;
  final Map<String, dynamic> extras;

  const QuestionMeta({
    required this.id,
    required this.topicId,
    required this.order,
    required this.difficulty,
    required this.type,
    this.translationDir,
    this.extras = const {},
  });

  factory QuestionMeta.fromJson(Map<String, dynamic> json) {
    const knownKeys = {
      'id',
      'topic_id',
      'order',
      'difficulty',
      'type',
      'translation_dir',
    };

    return QuestionMeta(
      id: json['id'] as String,
      topicId: json['topic_id'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      difficulty: json['difficulty'] as int? ?? 1,
      type: QuestionType.fromString(json['type'] as String?),
      translationDir: TranslationDirection.fromString(
        json['translation_dir'] as String?,
      ),
      extras: Map.fromEntries(
        json.entries.where((e) => !knownKeys.contains(e.key)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic_id': topicId,
        'order': order,
        'difficulty': difficulty,
        'type': type.toJsonString(),
        if (translationDir != null)
          'translation_dir': translationDir!.toJsonString(),
        ...extras,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is QuestionMeta && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'QuestionMeta($id, type: $type)';
}

/// 문제 콘텐츠 (로케일별 텍스트)
///
/// JSON 예시 (questions/ko/grammar_a1.json):
/// {
///   "q_gram_a1_01_001": {
///     "question": "___ libro es interesante.",
///     "correct": "El",
///     "wrong": ["La", "Los", "Las"],
///     "explanation": "'libro'는 남성 단수 명사이므로...",
///     "context": null,
///     "hint": "libro는 남성 명사입니다",
///     "conjugation_info": null
///   }
/// }
class QuestionContent {
  final String question;
  final String correct;
  final List<String> wrong;
  final String explanation;
  final String? context;
  final String? hint;
  final String? conjugationInfo;
  final Map<String, dynamic> extras;

  const QuestionContent({
    required this.question,
    required this.correct,
    required this.wrong,
    required this.explanation,
    this.context,
    this.hint,
    this.conjugationInfo,
    this.extras = const {},
  });

  factory QuestionContent.fromJson(Map<String, dynamic> json) {
    const knownKeys = {
      'question',
      'correct',
      'wrong',
      'explanation',
      'context',
      'hint',
      'conjugation_info',
    };

    return QuestionContent(
      question: json['question'] as String? ?? '',
      correct: json['correct'] as String? ?? '',
      wrong: (json['wrong'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      explanation: json['explanation'] as String? ?? '',
      context: json['context'] as String?,
      hint: json['hint'] as String?,
      conjugationInfo: json['conjugation_info'] as String?,
      extras: Map.fromEntries(
        json.entries.where((e) => !knownKeys.contains(e.key)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'correct': correct,
        'wrong': wrong,
        'explanation': explanation,
        if (context != null) 'context': context,
        if (hint != null) 'hint': hint,
        if (conjugationInfo != null) 'conjugation_info': conjugationInfo,
        ...extras,
      };

  static const empty = QuestionContent(
    question: '',
    correct: '',
    wrong: [],
    explanation: '',
  );

  @override
  String toString() {
    final preview =
        question.length > 30 ? '${question.substring(0, 30)}...' : question;
    return 'QuestionContent($preview)';
  }
}

/// Question (Meta + Content 통합, 런타임용)
class Question {
  final String id;
  final String topicId;
  final int order;
  final int difficulty;
  final QuestionType type;
  final TranslationDirection? translationDir;
  final String question;
  final String correct;
  final List<String> wrong;
  final String explanation;
  final String? context;
  final String? hint;
  final String? conjugationInfo;

  const Question({
    required this.id,
    required this.topicId,
    required this.order,
    required this.difficulty,
    required this.type,
    this.translationDir,
    required this.question,
    required this.correct,
    required this.wrong,
    required this.explanation,
    this.context,
    this.hint,
    this.conjugationInfo,
  });

  factory Question.fromMetaAndContent(
    QuestionMeta meta,
    QuestionContent content,
  ) {
    return Question(
      id: meta.id,
      topicId: meta.topicId,
      order: meta.order,
      difficulty: meta.difficulty,
      type: meta.type,
      translationDir: meta.translationDir,
      question: content.question,
      correct: content.correct,
      wrong: content.wrong,
      explanation: content.explanation,
      context: content.context,
      hint: content.hint,
      conjugationInfo: content.conjugationInfo,
    );
  }

  factory Question.fromMetaOnly(QuestionMeta meta) {
    return Question(
      id: meta.id,
      topicId: meta.topicId,
      order: meta.order,
      difficulty: meta.difficulty,
      type: meta.type,
      translationDir: meta.translationDir,
      question: meta.id,
      correct: '',
      wrong: [],
      explanation: '',
    );
  }

  QuestionMeta get meta => QuestionMeta(
        id: id,
        topicId: topicId,
        order: order,
        difficulty: difficulty,
        type: type,
        translationDir: translationDir,
      );

  QuestionContent get content => QuestionContent(
        question: question,
        correct: correct,
        wrong: wrong,
        explanation: explanation,
        context: context,
        hint: hint,
        conjugationInfo: conjugationInfo,
      );

  /// 선지 섞기 (매번 다른 순서)
  List<String> getShuffledOptions() {
    final options = [correct, ...wrong];
    options.shuffle();
    return options;
  }

  /// 섞인 선지에서 정답 인덱스
  int getCorrectIndex(List<String> shuffledOptions) {
    return shuffledOptions.indexOf(correct);
  }

  bool get isTranslation => type == QuestionType.translation;
  bool get isFillBlank => type == QuestionType.fillBlank;
  bool get isConjugation => type == QuestionType.conjugation;
  bool get isMeaning => type == QuestionType.meaning;
  bool get isContext => type == QuestionType.context;

  bool get hasContext => context != null && context!.isNotEmpty;
  bool get hasHint => hint != null && hint!.isNotEmpty;
  bool get hasConjugationInfo =>
      conjugationInfo != null && conjugationInfo!.isNotEmpty;

  /// TTS 재생이 유용한 문제 여부
  bool get needsTts =>
      type == QuestionType.listening ||
      type == QuestionType.translation ||
      type == QuestionType.meaning;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Question && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Question($id, type: $type)';
}
