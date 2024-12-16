import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/utils/api_utils.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

class FloorCvApi extends RestApi {
  static final FloorCvApi _instance =
      FloorCvApi(baseUrl: kDebugMode ? 'http://192.168.178.46:8080' : 'https://fastapi-670589174841.europe-west1.run.app');

  FloorCvApi({required super.baseUrl});

  static FloorCvApi get instance => _instance;

  Future<ScanPropertiesDto> scanCapture(SelectedFile capture, {CancelToken? cancelToken}) async {
    final response = await uploadFile<JsonObject>(route: '/scan', file: capture, cancelToken: cancelToken);
    return ScanPropertiesDto.fromJson(response.data!);
  }
}
