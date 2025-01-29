import 'dart:typed_data';

import 'package:mime/mime.dart';

abstract class ImageUtils {
  static bool isImage(Uint8List data) => lookupMimeType('', headerBytes: data)?.contains('image') ?? false;
}
