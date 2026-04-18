import 'package:drift/drift.dart';

/// 말하기 시도 로그 테이블
@DataClassName('SpeakingRecord')
class SpeakingRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// 씨앗 문장 ID (seeds_es.json의 id)
  TextColumn get seedId => text()();

  /// 변형 카드 ID (seedId::variation 형식)
  TextColumn get cardId => text()();

  /// 모드: 'practice' | 'review' (legacy 'test' 값도 존재할 수 있음)
  TextColumn get mode => text()();

  /// 사용자가 발화한 (STT) 텍스트
  TextColumn get spokenText => text().withDefault(const Constant(''))();

  /// 목표 텍스트
  TextColumn get targetText => text()();

  /// 정확도 (0.0 ~ 1.0)
  RealColumn get accuracy => real().withDefault(const Constant(0.0))();

  /// 통과 여부 (accuracy >= 0.8)
  BoolColumn get passed => boolean().withDefault(const Constant(false))();

  /// 학습 시각
  DateTimeColumn get studiedAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
