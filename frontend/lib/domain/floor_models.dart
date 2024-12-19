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
  createdAt,
  documentDate;

  String get name => switch (this) {
        DocumentSortType.modifiedAt => 'Bearbeitungsdatum',
        DocumentSortType.createdAt => 'Erstelldatum',
        DocumentSortType.documentDate => 'Dokumentdatum',
      };
}

class Selection {
  String? uuid;
  double x1;
  double x2;
  double y1;
  double y2;

  Selection({
    this.uuid,
    required this.x1,
    required this.x2,
    required this.y1,
    required this.y2,
  });
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

  bool get selectionsReady => selections.entries.length == captures.length;
}
