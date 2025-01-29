import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:paper_cv/features/document/data/sources/drift/database.dart';
import 'package:paper_cv/generated/l10n.dart';
import 'package:paper_cv/core/utils/file_picker_models.dart';

import '../../../domain/models/floor_models.dart';

extension Migration on FloorDatabase {
  int get version => 1;

  MigrationStrategy get getMigration => MigrationStrategy(
        beforeOpen: (details) async {},
        onCreate: (migrator) async {
          await migrator.createAll();
          final now = DateTime.now();

          final byteData = await rootBundle.load('assets/example.jpg');
          final DocumentForm form = DocumentForm(
            title: S.current.document,
            createdAt: now,
            modifiedAt: now,
            documentDate: now,
            captures: [
              SelectedFile(
                filename: '${S.current.example}.jpg',
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
