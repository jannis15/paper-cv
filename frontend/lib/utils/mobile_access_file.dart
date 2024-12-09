import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:paper_cv/utils/file_picker_models.dart';
import 'package:path_provider/path_provider.dart';

void accessFile(SelectedFile file) async {
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/${file.filename}';
  final tmpFile = File(path);
  await tmpFile.writeAsBytes(file.data);
  await OpenFile.open(path);
}
