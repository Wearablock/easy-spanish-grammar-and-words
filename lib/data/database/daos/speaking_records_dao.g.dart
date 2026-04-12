// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaking_records_dao.dart';

// ignore_for_file: type=lint
mixin _$SpeakingRecordsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SpeakingRecordsTable get speakingRecords => attachedDatabase.speakingRecords;
  SpeakingRecordsDaoManager get managers => SpeakingRecordsDaoManager(this);
}

class SpeakingRecordsDaoManager {
  final _$SpeakingRecordsDaoMixin _db;
  SpeakingRecordsDaoManager(this._db);
  $$SpeakingRecordsTableTableManager get speakingRecords =>
      $$SpeakingRecordsTableTableManager(
        _db.attachedDatabase,
        _db.speakingRecords,
      );
}
