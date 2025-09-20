import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/model/user.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String? baseUrl}) = _UserApi;

  @GET('/api/user/profile')
  Future<BaseResponse<User>> getUserProfile();

  // @PUT('/api/user/profile')
  // Future<BaseResponse<User>> updateUserProfile(
  //     @Body() UpdateProfileRequest request);
}
