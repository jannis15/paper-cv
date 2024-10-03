import 'dart:convert';
import 'dart:typed_data';

import 'package:floor_cv/data/models/floor_dto_models.dart';

enum FilePickerOption {
  camera,
  gallery;
}

class SelectedFile {
  String? id;
  final String name;
  final Uint8List bytes;

  String get base64String => base64Encode(bytes);

  SelectedFile({
    this.id,
    required this.name,
    required this.bytes,
  });
}

extension FileExtension on FileDto {
  SelectedFile toSelectedFile() => SelectedFile(
        id: this.uuid,
        name: this.filename,
        bytes: this.data,
      );
}
