import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_bump_app/data/remote/request/user/update_profile_request.dart';
import 'package:flutter_bump_app/data/remote/response/user/user_profile_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String? baseUrl}) = _UserApi;

  @GET('/api/user/profile')
  Future<BaseResponse<UserProfile>> getUserProfile();

  @PUT('/api/user/profile')
  Future<BaseResponse<UserProfile>> updateUserProfile(
      @Body() UpdateProfileRequest request);
}
