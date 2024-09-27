import 'package:floor_cv/data/models/floor_dto_models.dart';
import 'package:floor_cv/data/sources/local/database.dart';
import 'package:floor_cv/data/sources/remote/floor_cv_api.dart';
import 'package:floor_cv/domain/floor_models.dart';

abstract class FloorRepository {
  static Stream<List<DocumentPreviewDto>> watchDocumentPreviews() => FloorDatabase.instance.watchDocumentPreviews();

  static Future<void> deleteDocumentById(String documentId) => FloorDatabase.instance.deleteDocumentById(documentId);

  static Future<DocumentForm> getDocumentFormById(String documentId) => FloorDatabase.instance.getDocumentFormById(documentId);

  static Future<void> saveDocumentForm(DocumentForm form) => FloorDatabase.instance.saveDocumentForm(form);

  static Future<void> scanCapture(FileDto capture) => FloorCvApi.instance.scanCapture(capture);
}
