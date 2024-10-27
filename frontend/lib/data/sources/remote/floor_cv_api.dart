import 'package:paper_cv/data/models/floor_dto_models.dart';
import 'package:paper_cv/utils/api_utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaperCvApi extends RestApi {
  static final PaperCvApi _instance = PaperCvApi(baseUrl: dotenv.get('PAPER_CV_SCHEME') + dotenv.get('PAPER_CV_DOMAIN'));

  PaperCvApi({required super.baseUrl});

  static PaperCvApi get instance => _instance;

  Future<ScanPropertiesDto> scanCapture(FileDto capture) async {
    final response = await uploadFile<JsonObject>(route: '/scan', file: capture);
    return ScanPropertiesDto.fromJson(response.data!);
  }
}
