import 'package:dio/dio.dart';
import 'package:paper_cv/features/document/domain/models/floor_models.dart';
import 'package:paper_cv/features/document/data/sources/drift/database.dart';
import 'package:paper_cv/features/document/data/sources/fastapi/floor_cv_api.dart';
import 'package:paper_cv/core/utils/file_picker_models.dart';
import '../../../../core/utils/sort_enums.dart';

abstract class FloorRepository {
  static Stream<List<DocumentPreviewDto>> watchDocumentPreviews({
    required DocumentSortType sortType,
    required SortDirection sortDirection,
  }) =>
      FloorDatabase.instance.watchDocumentPreviews(
        sortType: sortType,
        sortDirection: sortDirection,
      );

  static Future<void> deleteDocumentById(String documentId) => FloorDatabase.instance.deleteDocumentById(documentId);

  static Future<DocumentForm> getDocumentFormById(String documentId) => FloorDatabase.instance.getDocumentFormById(documentId);

  static Future<void> saveDocumentForm(DocumentForm form) => FloorDatabase.instance.saveDocumentForm(form);

  static Future<ScanResultDto> scanCapture(SelectedFile capture, ScanPropertiesDto scanPropertiesDto, {CancelToken? cancelToken}) =>
      FloorCvApi.instance.scanCapture(capture, scanPropertiesDto, cancelToken: cancelToken);

  static Future<ScanRecalculationDto> recalculateScan(ScanRecalculationDto scanRecalculationDto, {CancelToken? cancelToken}) =>
      FloorCvApi.instance.recalculateScan(scanRecalculationDto, cancelToken: cancelToken);

  static Future<void> saveDocumentFile({required SelectedFile file, required String documentId}) =>
      FloorDatabase.instance.saveDocumentFile(file: file, documentId: documentId);

  static Future<SelectedFile> exportXLSX(ScanResultDto scanResultDto, {required String locale, CancelToken? cancelToken}) =>
      FloorCvApi.instance.exportXLSX(scanResultDto, locale: locale, cancelToken: cancelToken);
}
