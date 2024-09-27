import 'dart:io';

import 'package:dio/dio.dart';
import 'package:floor_cv/data/models/floor_dto_models.dart';

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

class RestApi {
  late final Dio _client;
  late final String _baseUrl;

  RestApi({required String baseUrl}) {
    _client = Dio();
    _baseUrl = baseUrl;
  }

  Future<void> uploadFile({required String route, required FileDto file}) async {
    final multiPartFile = await MultipartFile.fromBytes(file.data, filename: file.filename);
    await _client.post(
      _baseUrl + route,
      data: multiPartFile,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.multipartFormDataContentType,
        },
      ),
    );
  }
}
