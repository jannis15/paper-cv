import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/data/sources/local/migration.dart';
import 'package:paper_cv/data/sources/local/tables.dart';
import 'package:paper_cv/domain/floor_models.dart';
import 'package:paper_cv/utils/db_mixin.dart';
import 'package:paper_cv/utils/enum_utils.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:paper_cv/utils/type_converters.dart';
import 'package:uuid/uuid.dart';
import 'mobile_database.dart' if (dart.library.html) 'web_database.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  TbDocument,
  TbSelection,
  TbFile,
])
class FloorDatabase extends _$FloorDatabase with DbMixin {
  FloorDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => version;

  @override
  MigrationStrategy get migration => getMigration;

  static final _instance = FloorDatabase(openConnection());

  static FloorDatabase get instance => _instance;

  DocumentPreviewDto _mapToDocumentPreviewDto(TbDocumentData row) => DocumentPreviewDto(
        uuid: row.uuid,
        title: row.title,
        createdAt: row.createdAt,
        modifiedAt: row.modifiedAt,
        isExample: row.isExample,
      );

  SelectedFile _mapToSelectedFile(TbFileData row) => SelectedFile(
        uuid: row.uuid,
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

  Stream<List<DocumentPreviewDto>> watchDocumentPreviews({
    required DocumentSortType sortType,
    required SortDirection sortDirection,
  }) {
    final query = select(tbDocument).join([]);
    final column = switch (sortType) {
      DocumentSortType.modifiedAt => tbDocument.modifiedAt,
      DocumentSortType.createdAt => tbDocument.createdAt,
      DocumentSortType.documentDate => tbDocument.documentDate,
    };
    final orderTerm = switch (sortDirection) {
      SortDirection.ascending => OrderingTerm.asc(column),
      SortDirection.descending => OrderingTerm.desc(column),
    };
    query.orderBy([orderTerm]);
    return query.map((row) => _mapToDocumentPreviewDto(row.readTable(tbDocument)!)).watch();
  }

  Future<List<SelectedFile>> _getFilesByDocumentId(String documentId) async {
    final query = select(tbFile).join([]);
    query.where(tbFile.refUuid.isValue(documentId));
    query.orderBy([OrderingTerm(expression: tbFile.modifiedAt)]);
    final result = await query.get();
    return result.map((row) => _mapToSelectedFile(row.readTable(tbFile))).toList();
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
        documentDate: tbDocumentRow.documentDate,
        captures: captures,
        scans: scans,
        reports: reports,
      );

      await _loadSelections(form);

      return form;
    }
  }

  Future<void> saveDocumentFile({required SelectedFile file, required String documentId}) async {
    if (file.uuid != null) return;
    final String newUuid = Uuid().v4().toString();
    file.uuid ??= newUuid;
    await into(tbFile).insertOnConflictUpdate(
      TbFileCompanion(
        uuid: Value(file.uuid!),
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

  Future<void> _deleteUnlinkedSelections(String documentId, List<String> existingSelectionIds) async {
    final query = delete(tbSelection);
    query.where((_) => tbSelection.documentId.isValue(documentId));
    query.where((_) => tbSelection.uuid.isNotIn(existingSelectionIds));
    await query.go();
  }

  Future<void> _loadSelections(DocumentForm form) async {
    if (form.captures.isEmpty) return;
    final query = select(tbSelection);
    query.where((_) => tbSelection.documentId.isValue(form.uuid!));
    final selections = await query.get();
    for (final selection in selections) {
      final capture = form.captures.firstWhereOrNull((capture) => capture.uuid! == selection.fileId);
      if (capture == null) continue;
      form.selections[capture] = Selection(
        tX1: selection.tX1,
        tX2: selection.tX2,
        tY1: selection.tY1,
        tY2: selection.tY2,
        hX1: selection.hX1,
        hX2: selection.hX2,
        hY1: selection.hY1,
        hY2: selection.hY2,
      );
    }
  }

  Future<void> _saveSelection({required String documentId, required String fileId, required Selection selection}) async {
    selection.uuid ??= Uuid().v4().toString();
    await into(tbSelection).insertOnConflictUpdate(
      TbSelectionCompanion(
        uuid: Value(selection.uuid!),
        documentId: Value(documentId),
        fileId: Value(fileId),
        tX1: Value(selection.tX1),
        tX2: Value(selection.tX2),
        tY1: Value(selection.tY1),
        tY2: Value(selection.tY2),
        hX1: Value(selection.hX1),
        hX2: Value(selection.hX2),
        hY1: Value(selection.hY1),
        hY2: Value(selection.hY2),
      ),
    );
  }

  Future<void> saveDocumentForm(DocumentForm form, {bool? isExample}) async {
    await transaction(
      () async {
        final DateTime now = DateTime.now();
        final String formUuid = form.uuid ?? Uuid().v4().toString();
        await into(tbDocument).insertOnConflictUpdate(
          TbDocumentCompanion(
            uuid: Value(formUuid),
            title: Value(form.title),
            notes: Value(form.notes),
            createdAt: Value(form.createdAt ?? now),
            modifiedAt: Value(now),
            documentDate: Value(form.documentDate),
            isExample: Value.absentIfNull(isExample),
          ),
        );
        final List<String> existingfileIds = [
          ...form.captures.map((e) => e.uuid),
          ...form.scans.map((e) => e.uuid),
          ...form.reports.map((e) => e.uuid),
        ].whereType<String>().toList();
        await _deleteUnlinkedFiles(formUuid, existingfileIds);
        for (final capture in form.captures) {
          await saveDocumentFile(file: capture, documentId: formUuid);
        }
        for (final scan in form.scans) {
          await saveDocumentFile(file: scan, documentId: formUuid);
        }
        for (final reports in form.reports) {
          await saveDocumentFile(file: reports, documentId: formUuid);
        }
        await _deleteUnlinkedSelections(formUuid, form.selections.values.map((selection) => formUuid).whereNotNull().toList());
        for (final selectionEntry in form.selections.entries) {
          await _saveSelection(documentId: formUuid, fileId: selectionEntry.key.uuid!, selection: selectionEntry.value);
        }
      },
    );
  }
}
