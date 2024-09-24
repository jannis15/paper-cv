import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:floor_cv/data/models/floor_dto_models.dart';
import 'package:floor_cv/data/sources/local/migration.dart';
import 'package:floor_cv/data/sources/local/tables.dart';
import 'package:floor_cv/utils/db_mixin.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DriftDatabase(tables: [TbDocument])
class FloorDatabase extends _$FloorDatabase with DbMixin {
  FloorDatabase() : super(_openConnection());

  @override
  int get schemaVersion => version;

  @override
  MigrationStrategy get migration => getMigration;

  static final _instance = FloorDatabase();

  static FloorDatabase get instance => _instance;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'floor_cv');
  }

  DocumentPreviewDto _mapToDocumentPreviewDto(TbDocumentData row) => DocumentPreviewDto(
        uuid: row.uuid,
        title: row.title,
        createdAt: row.createdAt,
        modifiedAt: row.modifiedAt,
      );

  Future<void> deleteDocumentById(String documentId) async {
    final query = delete(tbDocument)..where((tbl) => tbl.uuid.isValue(documentId));
    await query.go();
  }

  Stream<List<DocumentPreviewDto>> watchDocumentPreviews() {
    final query = select(tbDocument).join([]);
    query.orderBy([
      OrderingTerm.desc(tbDocument.modifiedAt),
      OrderingTerm.desc(tbDocument.createdAt),
    ]);
    return query.map((row) => _mapToDocumentPreviewDto(row.readTable(tbDocument)!)).watch();
  }
}
