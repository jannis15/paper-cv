import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/utils/api_utils.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

class FloorCvApi extends RestApi {
  static final FloorCvApi _instance =
      FloorCvApi(baseUrl: kDebugMode ? 'http://192.168.178.46:8080' : 'https://floor-cv-670589174841.europe-west1.run.app');

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
}
