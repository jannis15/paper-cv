import 'dart:convert';
import 'dart:typed_data';
import 'package:paper_cv/data/models/floor_enums.dart';

enum FilePickerOption {
  camera,
  gallery;
}

class SelectedFile {
  String? uuid;
  String filename;
  final Uint8List data;
  final int? index;
  FileType fileType;
  final DateTime createdAt;
  final DateTime modifiedAt;

  String get base64String => base64Encode(data);

  SelectedFile({
    this.uuid,
    required this.filename,
    required this.data,
    this.index,
    this.fileType = FileType.attachment,
    required this.createdAt,
    required this.modifiedAt,
  });
}
