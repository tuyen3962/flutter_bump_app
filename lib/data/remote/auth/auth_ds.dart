import 'package:dio/dio.dart';
import 'package:flutter_bump_app/config/service/provider/dio_provider.dart';
import 'package:flutter_bump_app/data/remote/request/auth/register_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_bump_app/data/remote/request/request.dart';

part 'auth_ds.g.dart';

@lazySingleton
@RestApi()
abstract class AuthDS {
  @factoryMethod
  factory AuthDS(DioProvider provider) => _AuthDS(provider.dio);

  @POST('/api/auth/login')
  Future<void> login(@Body() LoginRequest request);

  @POST('/api/auth/register')
  Future<void> register(@Body() RegisterRequest request);

  @POST('/api/auth/logout')
  Future<void> logout();

  @POST('/api/auth/refresh-token')
  Future<void> refreshToken(@Body() String refreshToken);

  @POST('/api/auth/verify-token')
  Future<void> verifyToken();

  @GET('/api/auth/oauth/google/callback')
  Future<void> googleCallback();
}
