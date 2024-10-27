import 'package:paper_cv/data/models/floor_dto_models.dart';

class DocumentForm {
  String? uuid;
  String title;
  String notes;
  List<FileDto> captures;
  List<FileDto> scans;
  List<FileDto> reports;
  DateTime? createdAt;
  DateTime? modifiedAt;

  DocumentForm({
    this.uuid,
    this.title = '',
    this.notes = '',
    required this.captures,
    required this.scans,
    required this.reports,
    this.createdAt,
    this.modifiedAt,
  });
}
