import 'package:paper_cv/utils/file_picker_models.dart';

class DocumentForm {
  String? uuid;
  String title;
  String notes;
  List<SelectedFile> captures;
  List<SelectedFile> scans = [];
  List<SelectedFile> reports = [];
  DateTime? createdAt;
  DateTime? modifiedAt;

  DocumentForm({
    this.uuid,
    this.title = '',
    this.notes = '',
    List<SelectedFile>? captures,
    List<SelectedFile>? scans,
    List<SelectedFile>? reports,
    this.createdAt,
    this.modifiedAt,
  })  : captures = captures ?? [],
        scans = scans ?? [],
        reports = reports ?? [];
}
