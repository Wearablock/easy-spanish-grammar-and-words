import 'package:drift/drift.dart';

/// 말하기 카드별 스페이스드 리피티션 진도 테이블.
///
/// `SpeakingRecords`(raw 시도 로그)와는 책임 분리:
/// - SpeakingRecords: 모든 시도 raw 데이터 (분석용)
/// - SpeakingProgress: 카드별 현재 SR 상태 (복습 스케줄링용)
@DataClassName('SpeakingProgressEntry')
class SpeakingProgress extends Table {
  /// 카드 ID — `seedId::variationKey` 형식 (예: ser_nationality::tu)
  TextColumn get cardId => text()();

  /// 씨앗 ID (역정규화, 시드별 진도 조회용)
  TextColumn get seedId => text()();

  /// 학습 레벨 (0: 신규, 1-4: 학습중, 5: 마스터)
  IntColumn get level => integer().withDefault(const Constant(0))();

  IntColumn get passCount => integer().withDefault(const Constant(0))();
  IntColumn get failCount => integer().withDefault(const Constant(0))();

  DateTimeColumn get lastStudiedAt => dateTime().nullable()();
  DateTimeColumn get nextReviewAt => dateTime().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {cardId};
}
