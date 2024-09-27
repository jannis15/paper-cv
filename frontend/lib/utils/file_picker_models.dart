import 'dart:convert';
import 'dart:typed_data';

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
