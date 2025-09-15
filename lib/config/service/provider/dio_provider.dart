import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bump_app/config/constant/app_config.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/data/remote/interceptors/default_interceptor.dart';

@lazySingleton
class DioProvider {
  Dio? _dio;

  Dio get dio {
    _dio ??= _newDio();
    return _dio!;
  }

  Dio _newDio() {
    final dio = Dio(BaseOptions(baseUrl: AppConfig.API_URL));

    final interceptors = <Interceptor>[
      DefaultInterceptor(dio: dio, localStorage: locator.get())
    ];

    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }
    return dio..interceptors.addAll(interceptors);
  }
}
