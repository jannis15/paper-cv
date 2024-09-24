import 'dart:io';

import 'package:drift/drift.dart';

mixin DbMixin on GeneratedDatabase {
  Future<void> deleteDb() async {
    await customStatement('PRAGMA foreign_keys = OFF');
    try {
      await transaction(() async {
        for (final table in allTables) {
          await delete(table).go();
        }
      });
    } finally {
      await customStatement('PRAGMA foreign_keys = ON');
    }
    await optimizeSize();
  }

  Future<void> optimizeSize() => customStatement('VACUUM');

  Future<void> exportInto(File file) async {
    await file.parent.create(recursive: true);
    if (file.existsSync()) file.deleteSync();
    await customStatement('VACUUM INTO ?', [file.path]);
  }
}
