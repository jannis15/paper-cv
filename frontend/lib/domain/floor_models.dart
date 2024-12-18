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
  })  : captures = captures ?? [],
        scans = scans ?? [],
        reports = reports ?? [];
}
