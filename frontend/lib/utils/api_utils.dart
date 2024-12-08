import 'dart:io';
import 'package:dio/dio.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

class RestApi {
  late final Dio _client;
  late final String _baseUrl;

  RestApi({required String baseUrl}) {
    _client = Dio(BaseOptions(connectTimeout: Duration(seconds: 3)));
    _baseUrl = baseUrl;
  }

  Future<Response<T>> uploadFile<T>({required String route, required SelectedFile file}) async {
    final multiPartFile = await MultipartFile.fromBytes(file.data, filename: file.filename);
    final formData = FormData.fromMap({
      'file': multiPartFile,
    });
    return _client.post<T>(
      _baseUrl + route,
      data: formData,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.multipartFormDataContentType,
        },
      ),
    );
  }
}
