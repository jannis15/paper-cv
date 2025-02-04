import 'package:dio/dio.dart';
import 'package:paper_cv/features/document/domain/models/floor_models.dart';
import 'package:paper_cv/core/utils/sort_enums.dart';

import '../../../../core/utils/file_picker_models.dart';

abstract class FloorRepository {
  Stream<List<DocumentPreviewDto>> watchDocumentPreviews({
    required DocumentSortType sortType,
    required SortDirection sortDirection,
  });

  Future<void> deleteDocumentById(String documentId);

  Future<DocumentForm> getDocumentFormById(String documentId);

  Future<void> saveDocumentForm(DocumentForm form);

  Future<ScanResultDto> scanCapture(
    SelectedFile capture,
    ScanPropertiesDto scanPropertiesDto, {
    CancelToken? cancelToken,
  });

  Future<ScanRecalculationDto> recalculateScan(
    ScanRecalculationDto scanRecalculationDto, {
    CancelToken? cancelToken,
  });

  Future<void> saveDocumentFile({
    required SelectedFile file,
    required String documentId,
  });

  Future<SelectedFile> exportXLSX(
    ScanResultDto scanResultDto, {
    required String locale,
    CancelToken? cancelToken,
  });
}
