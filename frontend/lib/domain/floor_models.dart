import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

enum SortDirection {
  descending,
  ascending;

  SortDirection get opposite => switch (this) {
        SortDirection.descending => SortDirection.ascending,
        SortDirection.ascending => SortDirection.descending,
      };
}

enum DocumentSortType {
  modifiedAt,
  documentDate;

  String get name => switch (this) {
        DocumentSortType.modifiedAt => 'Bearbeitungsdatum',
        DocumentSortType.documentDate => 'Dokumentdatum',
      };
}

class Selection {
  String? uuid;
  double? tX1;
  double? tX2;
  double? tY1;
  double? tY2;
  double? hX1;
  double? hX2;
  double? hY1;
  double? hY2;

  Selection({
    this.uuid,
    this.tX1,
    this.tX2,
    this.tY1,
    this.tY2,
    this.hX1,
    this.hX2,
    this.hY1,
    this.hY2,
  });

  bool get isTSet => tX1 != null && tX2 != null && tY1 != null && tY2 != null;

  bool get isHSet => hX1 != null && hX2 != null && hY1 != null && hY2 != null;

  bool get isSet => this.isTSet && this.isHSet;

  SelectionDto toTDto() => SelectionDto(
        x1: tX1!,
        x2: tX2!,
        y1: tY1!,
        y2: tY2!,
      );
}

class DocumentForm {
  String? uuid;
  String title;
  String notes;
  List<SelectedFile> captures;
  List<SelectedFile> scans = [];
  List<SelectedFile> reports = [];
  DateTime? createdAt;
  DateTime? modifiedAt;
  DateTime? documentDate;
  Map<SelectedFile, Selection> selections;

  DocumentForm({
    this.uuid,
    this.title = '',
    this.notes = '',
    List<SelectedFile>? captures,
    List<SelectedFile>? scans,
    List<SelectedFile>? reports,
    this.createdAt,
    this.modifiedAt,
    this.documentDate,
    Map<SelectedFile, Selection>? selections,
  })  : captures = captures ?? [],
        scans = scans ?? [],
        reports = reports ?? [],
        selections = selections ?? {};

  bool get selectionsReady => selections.entries.map((entry) => entry.value.isTSet).where((entry) => entry).length == captures.length;
}

class ScanForm {
  String? uuid;
  List<double> columnWidthsCm;
  double avgRowHeightCm;
  int rows;
  double tableXCm;
  double tableYCm;
  double imgWidthPx;
  double imgHeightPx;
  List<List<String>> cellTexts;

  ScanForm({
    this.uuid,
    required this.columnWidthsCm,
    required this.avgRowHeightCm,
    required this.rows,
    required this.tableXCm,
    required this.tableYCm,
    required this.imgWidthPx,
    required this.imgHeightPx,
    required this.cellTexts,
  });

  ScanResultDto toDto() => ScanResultDto(
        uuid: this.uuid,
        columnWidthsCm: this.columnWidthsCm,
        avgRowHeightCm: this.avgRowHeightCm,
        rows: this.rows,
        tableXCm: this.tableXCm,
        tableYCm: this.tableYCm,
        imgWidthPx: this.imgWidthPx,
        imgHeightPx: this.imgHeightPx,
        cellTexts: this.cellTexts,
      );
}
