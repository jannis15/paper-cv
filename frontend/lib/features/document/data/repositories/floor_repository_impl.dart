import 'package:dio/dio.dart';
import 'package:paper_cv/features/document/domain/models/floor_models.dart';
import 'package:paper_cv/features/document/data/sources/drift/database.dart';
import 'package:paper_cv/features/document/data/sources/fastapi/floor_cv_api.dart';
import 'package:paper_cv/core/utils/file_picker_models.dart';
import 'package:paper_cv/features/document/domain/repositories/floor_repository.dart';
import '../../../../core/utils/sort_enums.dart';

class FloorRepositoryImpl implements FloorRepository {
  static FloorRepositoryImpl? _instance;

  factory FloorRepositoryImpl() => _instance ??= FloorRepositoryImpl();

  Stream<List<DocumentPreviewDto>> watchDocumentPreviews({
    required DocumentSortType sortType,
    required SortDirection sortDirection,
  }) =>
      FloorDatabase.instance.watchDocumentPreviews(
        sortType: sortType,
        sortDirection: sortDirection,
      );

  Future<void> deleteDocumentById(String documentId) => FloorDatabase.instance.deleteDocumentById(documentId);

  Future<DocumentForm> getDocumentFormById(String documentId) => FloorDatabase.instance.getDocumentFormById(documentId);

  Future<void> saveDocumentForm(DocumentForm form) => FloorDatabase.instance.saveDocumentForm(form);

  Future<ScanResultDto> scanCapture(SelectedFile capture, ScanPropertiesDto scanPropertiesDto, {CancelToken? cancelToken}) =>
      FloorCvApi.instance.scanCapture(capture, scanPropertiesDto, cancelToken: cancelToken);

  Future<ScanRecalculationDto> recalculateScan(ScanRecalculationDto scanRecalculationDto, {CancelToken? cancelToken}) =>
      FloorCvApi.instance.recalculateScan(scanRecalculationDto, cancelToken: cancelToken);

  Future<void> saveDocumentFile({required SelectedFile file, required String documentId}) =>
      FloorDatabase.instance.saveDocumentFile(file: file, documentId: documentId);

  Future<SelectedFile> exportXLSX(ScanResultDto scanResultDto, {required String locale, CancelToken? cancelToken}) =>
      FloorCvApi.instance.exportXLSX(scanResultDto, locale: locale, cancelToken: cancelToken);
}
