import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/data/sources/local/migration.dart';
import 'package:paper_cv/data/sources/local/tables.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/db_mixin.dart';
import 'package:paper_cv/utils/enum_utils.dart';
import 'package:paper_cv/utils/type_converters.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  TbDocument,
  TbFile,
])
class FloorDatabase extends _$FloorDatabase with DbMixin {
  FloorDatabase() : super(_openConnection());

  @override
  int get schemaVersion => version;

  @override
  MigrationStrategy get migration => getMigration;

  static final _instance = FloorDatabase();

  static FloorDatabase get instance => _instance;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'paper_cv');
  }

  DocumentPreviewDto _mapToDocumentPreviewDto(TbDocumentData row) => DocumentPreviewDto(
        uuid: row.uuid,
        title: row.title,
        createdAt: row.createdAt,
        modifiedAt: row.modifiedAt,
      );

  FileDto _mapToFileDto(TbFileData row) => FileDto(
        uuid: row.uuid,
        refUuid: row.refUuid,
        filename: row.filename,
        data: row.data,
        index: row.index,
        fileType: row.fileType as FileType,
        createdAt: row.createdAt,
        modifiedAt: row.modifiedAt,
      );

  Future<void> deleteDocumentById(String documentId) async {
    await transaction(
      () async {
        final query = delete(tbDocument)..where((tbl) => tbl.uuid.isValue(documentId));
        await query.go();
        await _deleteUnlinkedFiles(documentId, []);
      },
    );
    await optimizeSize();
  }

  Stream<List<DocumentPreviewDto>> watchDocumentPreviews() {
    final query = select(tbDocument).join([]);
    query.orderBy([
      OrderingTerm.desc(tbDocument.modifiedAt),
    ]);
    return query.map((row) => _mapToDocumentPreviewDto(row.readTable(tbDocument)!)).watch();
  }

  Future<List<FileDto>> _getFilesByDocumentId(String documentId) async {
    final query = select(tbFile).join([]);
    query.where(tbFile.refUuid.isValue(documentId));
    query.orderBy([OrderingTerm.desc(tbFile.modifiedAt)]);
    final result = await query.get();
    return result.map((row) => _mapToFileDto(row.readTable(tbFile))).toList();
  }

  Future<DocumentForm> getDocumentFormById(String documentId) async {
    final query = select(tbDocument).join([]);
    query.where(tbDocument.uuid.isValue(documentId));
    final result = await query.getSingleOrNull();
    if (result == null) {
      throw Exception('Could not load document by provided id.');
    } else {
      final tbDocumentRow = result.readTable(tbDocument);
      final files = await _getFilesByDocumentId(tbDocumentRow.uuid);
      final captures = files.where((file) => file.fileType == FileType.capture).toList();
      final scans = files.where((file) => file.fileType == FileType.scan).toList();
      final reports = files.where((file) => file.fileType == FileType.report).toList();
      final form = DocumentForm(
        uuid: tbDocumentRow.uuid,
        title: tbDocumentRow.title,
        notes: tbDocumentRow.notes,
        createdAt: tbDocumentRow.createdAt,
        modifiedAt: tbDocumentRow.modifiedAt,
        captures: captures,
        scans: scans,
        reports: reports,
      );
      return form;
    }
  }

  Future<void> _saveDocumentFile({required FileDto file, required String documentId}) async {
    if (file.uuid != null) return;
    final String newUuid = Uuid().v4().toString();
    await into(tbFile).insert(
      TbFileCompanion(
        uuid: Value(newUuid),
        refUuid: Value(documentId),
        filename: Value(file.filename),
        fileType: Value(file.fileType),
        data: Value(file.data),
        createdAt: Value(file.createdAt),
        modifiedAt: Value(file.modifiedAt),
      ),
    );
  }

  Future<void> _deleteUnlinkedFiles(String refUuid, List<String> existingFileIds) async {
    final query = delete(tbFile);
    query.where((_) => tbFile.refUuid.isValue(refUuid));
    query.where((_) => tbFile.uuid.isNotIn(existingFileIds));
    await query.go();
  }

  Future<void> saveDocumentForm(DocumentForm form) async {
    await transaction(
      () async {
        final DateTime now = DateTime.now();
        final String newUuid = form.uuid ?? Uuid().v4().toString();
        await into(tbDocument).insertOnConflictUpdate(
          TbDocumentCompanion(
            uuid: Value(newUuid),
            title: Value(form.title),
            notes: Value(form.notes),
            createdAt: Value(form.createdAt ?? now),
            modifiedAt: Value(now),
          ),
        );
        final List<String> existingfileIds = [
          ...form.captures.map((e) => e.uuid),
          ...form.scans.map((e) => e.uuid),
          ...form.reports.map((e) => e.uuid),
        ].whereType<String>().toList();
        await _deleteUnlinkedFiles(newUuid, existingfileIds);
        for (final capture in form.captures) {
          await _saveDocumentFile(file: capture, documentId: newUuid);
        }
        for (final scan in form.scans) {
          await _saveDocumentFile(file: scan, documentId: newUuid);
        }
        for (final reports in form.reports) {
          await _saveDocumentFile(file: reports, documentId: newUuid);
        }
      },
    );
  }
}
