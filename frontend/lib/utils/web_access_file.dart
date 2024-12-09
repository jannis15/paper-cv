import 'dart:html' as html;
import 'dart:typed_data';

import 'package:paper_cv/utils/file_picker_models.dart';

void accessFile(SelectedFile file) {
  _saveFileWeb(file.filename, file.data);
}

void _saveFileWeb(String fileName, Uint8List fileBytes) {
  final blob = html.Blob([fileBytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..target = '_blank'
    ..download = fileName
    ..click();
  html.Url.revokeObjectUrl(url);
}
