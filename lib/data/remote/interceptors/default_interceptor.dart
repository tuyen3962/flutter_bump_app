import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/local/local_storage.dart';

class DefaultInterceptor extends Interceptor {
  final Dio _dio;
  final LocalStorage _localStorage;
  DefaultInterceptor({required Dio dio, required LocalStorage localStorage})
      : _dio = dio,
        _localStorage = localStorage;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _localStorage.accessToken();
    if (token != null) {
      options.headers.putIfAbsent("Authorization", () => "Bearer $token");
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;

    if ((statusCode == HttpStatus.forbidden ||
        statusCode == HttpStatus.unauthorized)) {
      _renewToken(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _renewToken(
      DioException error, ErrorInterceptorHandler handler) async {
    try {
      /// * TODO
      /// request renewToken here
      ///
      /// error.requestOptions.headers["Authorization"] = "Bearer $_localStorage";
      ///
      ///
      /// *///

      final requestOptions = error.requestOptions;
      var requestData = requestOptions.data;
      final options = Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      );
      if (requestData is FormData) {
        requestData = requestData.clone();
      }

      // return errorHandler.resolve(request);
      var request = await _dio.request(
        "${requestOptions.baseUrl}${requestOptions.path}",
        data: requestData,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );
      handler.resolve(request);
    } catch (exception) {
      if (exception is DioException) {
        handler.next(exception);
      } else {
        handler.next(error);
      }
    }
  }
}
