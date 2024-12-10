import 'dart:io';
import 'package:dio/dio.dart';
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

  Future<Response<T>> uploadFile<T>({required String route, required SelectedFile file, CancelToken? cancelToken}) async {
    final multiPartFile = await MultipartFile.fromBytes(file.data, filename: file.filename);
    final formData = FormData.fromMap({
      'file': multiPartFile,
    });
    try {
      return await _client.post<T>(
        _baseUrl + route,
        cancelToken: cancelToken,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: Headers.multipartFormDataContentType,
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
