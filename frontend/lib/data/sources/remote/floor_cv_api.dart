import 'package:dio/dio.dart';
import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/utils/api_utils.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

class FloorCvApi extends RestApi {
  static final FloorCvApi _instance = FloorCvApi(baseUrl: 'http://192.168.178.46:443');

  FloorCvApi({required super.baseUrl});

  static FloorCvApi get instance => _instance;

  Future<ScanPropertiesDto> scanCapture(SelectedFile capture, {CancelToken? cancelToken}) async {
    final response = await uploadFile<JsonObject>(route: '/scan', file: capture, cancelToken: cancelToken);
    return ScanPropertiesDto.fromJson(response.data!);
  }
}
