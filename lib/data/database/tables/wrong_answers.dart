import 'package:drift/drift.dart';

/// 오답 기록 테이블
/// 틀린 문제의 상세 정보를 저장
@DataClassName('WrongAnswer')
class WrongAnswers extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 문제 ID (고유)
  TextColumn get questionId => text()();

  /// Topic ID (역정규화)
  TextColumn get topicId => text()();

  /// Level ID (역정규화)
  TextColumn get levelId => text()();

  /// 틀린 총 횟수
  IntColumn get wrongCount => integer().withDefault(const Constant(1))();

  /// 마지막으로 선택한 오답
  TextColumn get lastWrongAnswer => text().nullable()();

  /// 마지막으로 틀린 시간
  DateTimeColumn get wrongAt => dateTime()();

  /// 정답으로 맞춘 시간 (복습 완료)
  DateTimeColumn get correctedAt => dateTime().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {questionId},
      ];
}
