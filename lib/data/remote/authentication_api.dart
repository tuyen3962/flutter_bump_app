import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_api.g.dart';

@RestApi()
abstract class AuthenticationAPI {
  factory AuthenticationAPI(Dio dio, {String? baseUrl}) = _AuthenticationAPI;

 
}
