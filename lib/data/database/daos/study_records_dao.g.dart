// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_records_dao.dart';

// ignore_for_file: type=lint
mixin _$StudyRecordsDaoMixin on DatabaseAccessor<AppDatabase> {
  $StudyRecordsTable get studyRecords => attachedDatabase.studyRecords;
  StudyRecordsDaoManager get managers => StudyRecordsDaoManager(this);
}

class StudyRecordsDaoManager {
  final _$StudyRecordsDaoMixin _db;
  StudyRecordsDaoManager(this._db);
  $$StudyRecordsTableTableManager get studyRecords =>
      $$StudyRecordsTableTableManager(_db.attachedDatabase, _db.studyRecords);
}
