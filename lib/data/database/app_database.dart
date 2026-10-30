import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/study_records.dart';
import 'tables/wrong_answers.dart';
import 'tables/daily_stats.dart';
import 'tables/user_settings.dart';
import 'tables/speaking_records.dart';
import 'tables/speaking_progress.dart';
import 'daos/study_records_dao.dart';
import 'daos/user_settings_dao.dart';
import 'daos/daily_stats_dao.dart';
import 'daos/wrong_answers_dao.dart';
import 'daos/speaking_records_dao.dart';
import 'daos/speaking_progress_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    StudyRecords,
    WrongAnswers,
    DailyStats,
    UserSettings,
    SpeakingRecords,
    SpeakingProgress,
  ],
  daos: [
    StudyRecordsDao,
    UserSettingsDao,
    DailyStatsDao,
    WrongAnswersDao,
    SpeakingRecordsDao,
    SpeakingProgressDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(speakingRecords);
        }
        if (from < 3) {
          await m.createTable(speakingProgress);
        }
      },
    );
  }

  /// Clears every learning table — everything except user settings — in one transaction.
  /// Walks [allTables] so a table added later is reset too (speaking was missed until 1.5.1).
  Future<void> resetLearning() => transaction(() async {
        for (final table in allTables) {
          if (table is $UserSettingsTable) continue;
          await delete(table).go();
        }
      });

  @override
  StudyRecordsDao get studyRecordsDao => StudyRecordsDao(this);
  @override
  UserSettingsDao get userSettingsDao => UserSettingsDao(this);
  @override
  DailyStatsDao get dailyStatsDao => DailyStatsDao(this);
  @override
  WrongAnswersDao get wrongAnswersDao => WrongAnswersDao(this);
  @override
  SpeakingRecordsDao get speakingRecordsDao => SpeakingRecordsDao(this);
  @override
  SpeakingProgressDao get speakingProgressDao => SpeakingProgressDao(this);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'espanol_bite.db'));
    return NativeDatabase.createInBackground(file);
  });
}
