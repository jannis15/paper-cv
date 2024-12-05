import 'package:drift/drift.dart';
import 'package:paper_cv/data/sources/local/database.dart';

extension Migration on FloorDatabase {
  int get version => 1;

  MigrationStrategy get getMigration => MigrationStrategy(
        beforeOpen: (details) async {},
        onCreate: (migrator) async {
          await migrator.createAll();
          Future<void> insertDocument(TbDocumentCompanion entry) async {
            await into(tbDocument).insert(entry);
          }

          Future<void> insertTestData() async {
            final now = DateTime.now();
            List<TbDocumentCompanion> testData = [
              TbDocumentCompanion(
                title: Value('Dokument 1'),
                notes: Value(''),
                createdAt: Value(now),
                modifiedAt: Value(now),
              ),
              TbDocumentCompanion(
                title: Value('Dokument 2'),
                notes: Value(''),
                createdAt: Value(now.subtract(const Duration(days: 1))),
                modifiedAt: Value(now),
              ),
              TbDocumentCompanion(
                title: Value('Dokument 3'),
                notes: Value(''),
                createdAt: Value(now.subtract(const Duration(days: 2))),
                modifiedAt: Value(now.subtract(const Duration(days: 1))),
              ),
            ];
            for (final doc in testData) {
              await insertDocument(doc);
            }
          }

          await insertTestData();
        },
        onUpgrade: (migrator, from, to) async {},
      );
}
