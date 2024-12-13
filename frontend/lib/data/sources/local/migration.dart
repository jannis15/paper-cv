import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/data/sources/local/database.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

extension Migration on FloorDatabase {
  int get version => 1;

  MigrationStrategy get getMigration => MigrationStrategy(
        beforeOpen: (details) async {},
        onCreate: (migrator) async {
          await migrator.createAll();
          final now = DateTime.now();
          final byteData = await rootBundle.load('assets/example.jpg');
          final DocumentForm form = DocumentForm(
            title: 'Dokument',
            createdAt: now,
            modifiedAt: now,
            captures: [
              SelectedFile(
                filename: 'Beispiel.jpg',
                data: byteData.buffer.asUint8List(),
                createdAt: now,
                modifiedAt: now,
                fileType: FileType.capture,
              ),
            ],
          );
          await saveDocumentForm(form, isExample: true);
        },
        onUpgrade: (migrator, from, to) async {},
      );
}
