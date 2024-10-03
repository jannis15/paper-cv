import 'package:floor_cv/data/models/floor_dto_models.dart';
import 'package:floor_cv/utils/api_utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FloorCvApi extends RestApi {
  static final FloorCvApi _instance = FloorCvApi(baseUrl: dotenv.get('FLOOR_CV_SCHEME') + dotenv.get('FLOOR_CV_DOMAIN'));

  FloorCvApi({required super.baseUrl});

  static FloorCvApi get instance => _instance;

  Future<ScanPropertiesDto> scanCapture(FileDto capture) async {
    final response = await uploadFile<JsonObject>(route: '/scan', file: capture);
    return ScanPropertiesDto.fromJson(response.data!);
  }
}
