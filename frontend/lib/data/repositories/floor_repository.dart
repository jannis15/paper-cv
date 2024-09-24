import 'package:floor_cv/data/models/floor_dto_models.dart';
import 'package:floor_cv/data/sources/local/database.dart';

abstract class FloorRepository {
  static Stream<List<DocumentPreviewDto>> watchDocumentPreviews() => FloorDatabase.instance.watchDocumentPreviews();
  static Future<void> deleteDocumentById(String documentId) => FloorDatabase.instance.deleteDocumentById(documentId);
}
