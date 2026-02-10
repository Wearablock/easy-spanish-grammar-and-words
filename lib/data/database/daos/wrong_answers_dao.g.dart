// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrong_answers_dao.dart';

// ignore_for_file: type=lint
mixin _$WrongAnswersDaoMixin on DatabaseAccessor<AppDatabase> {
  $WrongAnswersTable get wrongAnswers => attachedDatabase.wrongAnswers;
  WrongAnswersDaoManager get managers => WrongAnswersDaoManager(this);
}

class WrongAnswersDaoManager {
  final _$WrongAnswersDaoMixin _db;
  WrongAnswersDaoManager(this._db);
  $$WrongAnswersTableTableManager get wrongAnswers =>
      $$WrongAnswersTableTableManager(_db.attachedDatabase, _db.wrongAnswers);
}
