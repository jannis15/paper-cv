import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';
import 'package:paper_cv/config/system.dart';
import 'package:paper_cv/utils/file_picker_models.dart';

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

class RestApi {
  late final Dio _client;
  late final String _baseUrl;

  RestApi({required String baseUrl}) {
    _client = Dio(BaseOptions(connectTimeout: Duration(seconds: 3), receiveTimeout: Duration(minutes: 1)));
    _client.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          logException(error, StackTrace.current);
          showException(error);
          handler.next(error);
        },
      ),
    );
    _baseUrl = baseUrl;
  }

  Future<Response<T>> post<T>({
    required String route,
    SelectedFile? file,
    Map<String, dynamic>? json,
    CancelToken? cancelToken,
  }) async {
    late final Object data;
    if (file != null) {
      data = FormData.fromMap({
        'file': await MultipartFile.fromBytes(
          file.data,
          filename: file.filename,
          contentType: DioMediaType.parse(lookupMimeType(file.filename) ?? ''),
        ),
        if (json != null) 'scan_properties': jsonEncode(json),
      });
    } else {
      data = json!;
    }

    try {
      return await _client.post<T>(
        _baseUrl + route,
        cancelToken: cancelToken,
        data: data,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: file != null ? Headers.multipartFormDataContentType : Headers.jsonContentType,
            if (!kDebugMode) HttpHeaders.accessControlAllowOriginHeader: 'true',
          },
        ),
      );
    } on DioException catch (_) {
      if ((cancelToken?.isCancelled ?? false) && cancelToken!.cancelError != null) {
        throw cancelToken.cancelError!;
      } else {
        rethrow;
      }
    }
  }
}
