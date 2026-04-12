// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaking_progress_dao.dart';

// ignore_for_file: type=lint
mixin _$SpeakingProgressDaoMixin on DatabaseAccessor<AppDatabase> {
  $SpeakingProgressTable get speakingProgress =>
      attachedDatabase.speakingProgress;
  SpeakingProgressDaoManager get managers => SpeakingProgressDaoManager(this);
}

class SpeakingProgressDaoManager {
  final _$SpeakingProgressDaoMixin _db;
  SpeakingProgressDaoManager(this._db);
  $$SpeakingProgressTableTableManager get speakingProgress =>
      $$SpeakingProgressTableTableManager(
        _db.attachedDatabase,
        _db.speakingProgress,
      );
}
