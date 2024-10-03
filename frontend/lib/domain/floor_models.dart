import 'package:floor_cv/data/models/floor_dto_models.dart';

class DocumentForm {
  String? uuid;
  String title;
  String notes;
  List<FileDto> captures;
  List<FileDto> scans;
  DateTime? createdAt;
  DateTime? modifiedAt;

  DocumentForm({
    this.uuid,
    this.title = '',
    this.notes = '',
    required this.captures,
    required this.scans,
    this.createdAt,
    this.modifiedAt,
  });
}
