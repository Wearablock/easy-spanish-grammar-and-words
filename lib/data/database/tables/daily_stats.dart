import 'package:drift/drift.dart';

/// 일일 학습 통계 테이블
/// 날짜별 학습 현황을 기록
@DataClassName('DailyStat')
class DailyStats extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 학습 날짜 (YYYY-MM-DD, 고유)
  DateTimeColumn get date => dateTime()();

  /// 학습한 총 문제 수
  IntColumn get questionsStudied =>
      integer().withDefault(const Constant(0))();

  /// 정답 수
  IntColumn get correctAnswers =>
      integer().withDefault(const Constant(0))();

  /// 학습 시간 (초)
  IntColumn get studyTimeSec =>
      integer().withDefault(const Constant(0))();

  /// 신규 문제 수
  IntColumn get newQuestions =>
      integer().withDefault(const Constant(0))();

  /// 복습 문제 수
  IntColumn get reviewQuestions =>
      integer().withDefault(const Constant(0))();

  /// 해당일 목표 문제 수
  IntColumn get dailyGoal =>
      integer().withDefault(const Constant(15))();

  /// 목표 달성 여부
  BoolColumn get goalAchieved =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {date},
      ];
}
