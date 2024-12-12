import 'package:drift/drift.dart';
import 'package:paper_cv/data/sources/local/database.dart';

extension Migration on FloorDatabase {
  int get version => 1;

  MigrationStrategy get getMigration => MigrationStrategy(
        beforeOpen: (details) async {},
        onCreate: (migrator) async {
          await migrator.createAll();
        },
        onUpgrade: (migrator, from, to) async {},
      );
}
