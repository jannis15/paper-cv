import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/data/models/floor_enums.dart';
import 'package:paper_cv/utils/api_utils.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

import '../../../config/settings.dart';
import '../../../utils/date_format_utils.dart';

class FloorCvApi extends RestApi {
  static final FloorCvApi _instance =
      FloorCvApi(baseUrl: kDebugMode ? 'http://192.168.178.46:53768' : 'https://floor-cv-249921154046.europe-west1.run.app');

  FloorCvApi({required super.baseUrl});

  static FloorCvApi get instance => _instance;

  Future<ScanResultDto> scanCapture(SelectedFile capture, ScanPropertiesDto scanPropertiesDto, {CancelToken? cancelToken}) async {
    final response = await post<JsonObject>(route: '/scan', file: capture, json: scanPropertiesDto.toJson(), cancelToken: cancelToken);
    return ScanResultDto.fromJson(response.data!);
  }

  Future<ScanRecalculationDto> recalculateScan(ScanRecalculationDto scanRecalculationDto, {CancelToken? cancelToken}) async {
    final response = await FloorCvApi.instance.post(route: '/recalculate', json: scanRecalculationDto.toJson(), cancelToken: cancelToken);
    return ScanRecalculationDto.fromJson(response.data!);
  }

  Future<SelectedFile> exportXLSX(ScanResultDto scanResultDto, {required String locale, CancelToken? cancelToken}) async {
    final response = await FloorCvApi.instance.post(
      responseType: ResponseType.bytes,
      route: '/export-xlsx',
      json: ScanRecalculationDto(
        cellTexts: scanResultDto.cellTexts,
        templateNo: 1,
      ).toJson(),
      cancelToken: cancelToken,
    );
    final now = DateTime.now();
    final String formattedDate = dateFormatDateTime(locale).format(now);
    final file = SelectedFile(
      filename: 'Spreadsheet ${formattedDate}.xlsx',
      data: Uint8List.fromList(response.data),
      createdAt: now,
      modifiedAt: now,
      fileType: FileType.report,
      refUuid: scanResultDto.refUuid,
    );
    return file;
  }
}
