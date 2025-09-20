import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/remote/exception/error_exception.dart';

abstract class IBaseRepository {
  handleError(error) {
    if (error is DioException) {
      if (error.response?.data is Map<String, dynamic>) {
        try {
          final data = error.response?.data as Map<String, dynamic>;
          final errorException = ErrorException.fromJson(data);
          throw errorException;
        } catch (e) {
          throw error;
        }
      }
    }
  }
}
