import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/speaking_records.dart';

part 'speaking_records_dao.g.dart';

@DriftAccessor(tables: [SpeakingRecords])
class SpeakingRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$SpeakingRecordsDaoMixin {
  SpeakingRecordsDao(super.db);

  Future<int> insertRecord(SpeakingRecordsCompanion record) {
    return into(speakingRecords).insert(record);
  }

  Future<List<SpeakingRecord>> getBySeed(String seedId) {
    return (select(speakingRecords)
          ..where((t) => t.seedId.equals(seedId))
          ..orderBy([(t) => OrderingTerm.desc(t.studiedAt)]))
        .get();
  }

  Future<int> getTotalCount() async {
    final count = speakingRecords.id.count();
    final query = selectOnly(speakingRecords)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  Future<int> getPassedCount() async {
    final count = speakingRecords.id.count();
    final query = selectOnly(speakingRecords)
      ..addColumns([count])
      ..where(speakingRecords.passed.equals(true));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  Future<int> deleteAll() => delete(speakingRecords).go();
}
