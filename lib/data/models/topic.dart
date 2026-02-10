/// Topic 메타데이터 (구조 정보, 언어 독립적)
///
/// JSON 예시 (topics_meta.json):
/// {
///   "id": "ch_gram_a1_01",
///   "level_id": "grammar_a1",
///   "category_id": "grammar",
///   "dele_level": "a1",
///   "order": 1,
///   "question_count": 8
/// }
class TopicMeta {
  final String id;
  final String levelId;
  final String categoryId;
  final String deleLevel;
  final int order;
  final int questionCount;
  final Map<String, dynamic> extras;

  const TopicMeta({
    required this.id,
    required this.levelId,
    required this.categoryId,
    required this.deleLevel,
    required this.order,
    required this.questionCount,
    this.extras = const {},
  });

  factory TopicMeta.fromJson(Map<String, dynamic> json) {
    const knownKeys = {
      'id',
      'level_id',
      'category_id',
      'dele_level',
      'order',
      'question_count',
    };

    return TopicMeta(
      id: json['id'] as String,
      levelId: json['level_id'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      deleLevel: json['dele_level'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      questionCount: json['question_count'] as int? ?? 0,
      extras: Map.fromEntries(
        json.entries.where((e) => !knownKeys.contains(e.key)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'level_id': levelId,
        'category_id': categoryId,
        'dele_level': deleLevel,
        'order': order,
        'question_count': questionCount,
        ...extras,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TopicMeta && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'TopicMeta($id, level: $levelId, order: $order)';
}

/// Topic 콘텐츠 (로케일별 텍스트)
///
/// JSON 예시 (topics_ko.json):
/// {
///   "ch_gram_a1_01": {
///     "title": "명사와 관사",
///     "title_es": "Sustantivos y artículos",
///     "theory": "## 스페인어 명사의 성\n\n...",
///     "key_points": ["포인트1", "포인트2"],
///     "vocab_list": [ { "word": "hola", "meaning": "안녕", ... } ]
///   }
/// }
class TopicContent {
  final String title;
  final String? titleEs;
  final String theory;
  final List<String>? keyPoints;
  final List<VocabEntry>? vocabList;
  final Map<String, dynamic> extras;

  const TopicContent({
    required this.title,
    this.titleEs,
    required this.theory,
    this.keyPoints,
    this.vocabList,
    this.extras = const {},
  });

  factory TopicContent.fromJson(Map<String, dynamic> json) {
    const knownKeys = {
      'title',
      'title_es',
      'theory',
      'key_points',
      'vocab_list',
    };

    return TopicContent(
      title: json['title'] as String? ?? '',
      titleEs: json['title_es'] as String?,
      theory: json['theory'] as String? ?? '',
      keyPoints: (json['key_points'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      vocabList: (json['vocab_list'] as List<dynamic>?)
          ?.map((e) => VocabEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      extras: Map.fromEntries(
        json.entries.where((e) => !knownKeys.contains(e.key)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        if (titleEs != null) 'title_es': titleEs,
        'theory': theory,
        if (keyPoints != null) 'key_points': keyPoints,
        if (vocabList != null)
          'vocab_list': vocabList!.map((e) => e.toJson()).toList(),
        ...extras,
      };

  static const empty = TopicContent(title: '', theory: '');

  @override
  String toString() => 'TopicContent($title)';
}

/// 어휘 엔트리 (vocab_list 내부 아이템)
///
/// JSON 예시:
/// {
///   "word": "hola",
///   "meaning": "안녕",
///   "pronunciation": "[올라]",
///   "example": "¡Hola! ¿Cómo estás?",
///   "example_meaning": "안녕! 어떻게 지내?"
/// }
class VocabEntry {
  final String word;
  final String meaning;
  final String? pronunciation;
  final String? example;
  final String? exampleMeaning;
  final Map<String, dynamic> extras;

  const VocabEntry({
    required this.word,
    required this.meaning,
    this.pronunciation,
    this.example,
    this.exampleMeaning,
    this.extras = const {},
  });

  factory VocabEntry.fromJson(Map<String, dynamic> json) {
    const knownKeys = {
      'word',
      'meaning',
      'pronunciation',
      'example',
      'example_meaning',
    };

    return VocabEntry(
      word: json['word'] as String? ?? '',
      meaning: json['meaning'] as String? ?? '',
      pronunciation: json['pronunciation'] as String?,
      example: json['example'] as String?,
      exampleMeaning: json['example_meaning'] as String?,
      extras: Map.fromEntries(
        json.entries.where((e) => !knownKeys.contains(e.key)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'word': word,
        'meaning': meaning,
        if (pronunciation != null) 'pronunciation': pronunciation,
        if (example != null) 'example': example,
        if (exampleMeaning != null) 'example_meaning': exampleMeaning,
        ...extras,
      };

  @override
  String toString() => 'VocabEntry($word: $meaning)';
}

/// Topic (Meta + Content 통합, 런타임용)
class Topic {
  final String id;
  final String levelId;
  final String categoryId;
  final String deleLevel;
  final int order;
  final int questionCount;
  final String title;
  final String? titleEs;
  final String theory;
  final List<String>? keyPoints;
  final List<VocabEntry>? vocabList;

  const Topic({
    required this.id,
    required this.levelId,
    required this.categoryId,
    required this.deleLevel,
    required this.order,
    required this.questionCount,
    required this.title,
    this.titleEs,
    required this.theory,
    this.keyPoints,
    this.vocabList,
  });

  /// Meta + Content 결합
  factory Topic.fromMetaAndContent(TopicMeta meta, TopicContent content) {
    return Topic(
      id: meta.id,
      levelId: meta.levelId,
      categoryId: meta.categoryId,
      deleLevel: meta.deleLevel,
      order: meta.order,
      questionCount: meta.questionCount,
      title: content.title.isNotEmpty ? content.title : meta.id,
      titleEs: content.titleEs,
      theory: content.theory,
      keyPoints: content.keyPoints,
      vocabList: content.vocabList,
    );
  }

  /// Meta만으로 생성 (콘텐츠 로딩 실패 시 fallback)
  factory Topic.fromMetaOnly(TopicMeta meta) {
    return Topic(
      id: meta.id,
      levelId: meta.levelId,
      categoryId: meta.categoryId,
      deleLevel: meta.deleLevel,
      order: meta.order,
      questionCount: meta.questionCount,
      title: meta.id,
      theory: '',
    );
  }

  bool get isGrammar => categoryId == 'grammar';

  bool get isVocabulary => categoryId == 'vocabulary';

  bool get hasVocabList => vocabList != null && vocabList!.isNotEmpty;

  bool get hasKeyPoints => keyPoints != null && keyPoints!.isNotEmpty;

  TopicMeta get meta => TopicMeta(
        id: id,
        levelId: levelId,
        categoryId: categoryId,
        deleLevel: deleLevel,
        order: order,
        questionCount: questionCount,
      );

  TopicContent get content => TopicContent(
        title: title,
        titleEs: titleEs,
        theory: theory,
        keyPoints: keyPoints,
        vocabList: vocabList,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Topic && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Topic($id, $title)';
}
