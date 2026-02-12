/// 학습 관련 상수
class StudyConstants {
  StudyConstants._();

  /// 스페이스드 리피티션 레벨별 복습 간격 (일)
  static const List<int> reviewIntervals = [1, 1, 3, 7, 14, 30];

  /// 최대 SRS 레벨
  static const int maxLevel = 5;

  /// 완전 습득 레벨 (= maxLevel, DAO에서 참조)
  static const int masteryLevel = 5;

  /// 오답 복습 최대 문제 수
  static const int maxWrongReviewCount = 10;

  /// 복습 세션 최대 문제 수 (오답 + 간격 반복 합산)
  static const int maxReviewCount = 10;

  /// 신규 학습 최소 보장 문제 수
  static const int minNewLearningCount = 5;

  /// 기본 일일 학습 토픽 수
  static const int defaultDailyTopics = 2;

  /// 기본 일일 학습 목표 (토픽 수, DAO에서 사용)
  static const int defaultDailyGoal = 2;

  /// 최대 일일 목표 토픽 수
  static const int maxDailyGoalTopics = 5;
}

/// CEFR 레벨 관련 상수
class LevelConstants {
  LevelConstants._();

  /// CEFR 레벨 목록
  static const List<String> levels = ['a1', 'a2', 'b1', 'b2', 'c1', 'c2'];

  /// 기본 목표 레벨
  static const String defaultTargetLevel = 'b1';

  /// 카테고리 ID
  static const String grammarCategory = 'grammar';
  static const String vocabularyCategory = 'vocabulary';

  /// 레벨 순서 맵
  static const Map<String, int> levelOrder = {
    'a1': 1,
    'a2': 2,
    'b1': 3,
    'b2': 4,
    'c1': 5,
    'c2': 6,
  };

  /// 목표 레벨 이하의 모든 레벨 반환
  static List<String> getLevelsUpTo(String targetLevel) {
    final targetOrder = levelOrder[targetLevel] ?? 3;
    return levels.where((l) => (levelOrder[l] ?? 0) <= targetOrder).toList();
  }
}

/// UI 상수
class UIConstants {
  UIConstants._();

  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;
}
