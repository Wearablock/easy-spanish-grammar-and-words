/// 레벨 ID 상수 (QuestionRepository에서 파일 로딩에 사용)
class LevelIds {
  LevelIds._();

  // Grammar 레벨
  static const grammarA1 = 'grammar_a1';
  static const grammarA2 = 'grammar_a2';
  static const grammarB1 = 'grammar_b1';
  static const grammarB2 = 'grammar_b2';
  static const grammarC1 = 'grammar_c1';
  static const grammarC2 = 'grammar_c2';

  // Vocabulary 레벨
  static const vocabA1 = 'vocab_a1';
  static const vocabA2 = 'vocab_a2';
  static const vocabB1 = 'vocab_b1';
  static const vocabB2 = 'vocab_b2';
  static const vocabC1 = 'vocab_c1';
  static const vocabC2 = 'vocab_c2';

  /// 전체 레벨 목록 (순서대로)
  static const List<String> all = [
    grammarA1, vocabA1,
    grammarA2, vocabA2,
    grammarB1, vocabB1,
    grammarB2, vocabB2,
    grammarC1, vocabC1,
    grammarC2, vocabC2,
  ];

  /// 레벨 순서 맵
  static const Map<String, int> order = {
    grammarA1: 1, vocabA1: 2,
    grammarA2: 3, vocabA2: 4,
    grammarB1: 5, vocabB1: 6,
    grammarB2: 7, vocabB2: 8,
    grammarC1: 9, vocabC1: 10,
    grammarC2: 11, vocabC2: 12,
  };
}
