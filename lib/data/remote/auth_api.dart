import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_bump_app/data/remote/request/auth/login_request.dart';
import 'package:flutter_bump_app/data/remote/request/auth/register_request.dart';
import 'package:flutter_bump_app/data/remote/request/auth/change_password_request.dart';
import 'package:flutter_bump_app/data/remote/request/auth/google_web_login_request.dart';
import 'package:flutter_bump_app/data/remote/request/auth/google_mobile_login_request.dart';
import 'package:flutter_bump_app/data/remote/request/auth/refresh_token_request.dart';
import 'package:flutter_bump_app/data/remote/response/auth/login_response.dart';
import 'package:flutter_bump_app/data/remote/response/auth/google_callback_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @POST('/api/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/api/auth/register')
  Future<BaseResponse<dynamic>> register(@Body() RegisterRequest request);

  @POST('/api/auth/logout')
  Future<BaseResponse<dynamic>> logout();

  @GET('/api/auth/oauth/google/callback')
  Future<GoogleCallbackResponse> googleCallback();

  @POST('/api/auth/refresh')
  Future<BaseResponse<dynamic>> refreshToken(
      @Body() RefreshTokenRequest request);

  @POST('/api/auth/change-password')
  Future<BaseResponse<dynamic>> changePassword(
      @Body() ChangePasswordRequest request);

  @GET('/api/auth/profile')
  Future<BaseResponse<dynamic>> getProfile();

  @PUT('/api/auth/profile')
  Future<BaseResponse<dynamic>> updateProfile(
      @Body() Map<String, dynamic> request);

  @POST('/api/auth/google/web')
  Future<GoogleCallbackResponse> googleWebLogin(
      @Body() GoogleWebLoginRequest request);

  @POST('/api/auth/google/mobile')
  Future<GoogleCallbackResponse> googleMobileLogin(
      @Body() GoogleMobileLoginRequest request);

  // @GET('/api/auth/google/url')
  // Future<Map<String, dynamic>> getGoogleAuthUrl();
}
