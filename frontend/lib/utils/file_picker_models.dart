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

  SelectedFile copyWith({
    String? uuid,
    String? filename,
    Uint8List? data,
    int? index,
    FileType? fileType,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return SelectedFile(
      uuid: uuid ?? this.uuid,
      filename: filename ?? this.filename,
      data: data ?? this.data,
      index: index ?? this.index,
      fileType: fileType ?? this.fileType,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}
