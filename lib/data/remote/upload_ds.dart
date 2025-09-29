import 'package:dio/dio.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/remote/response/upload/presign_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'upload_ds.g.dart';

@RestApi()
abstract class UploadDS {
  factory UploadDS(Dio dio, {String? baseUrl}) = _UploadDS;

  @GET('/api/uploads/presign/{resourceType}')
  Future<BaseResponse<PreSignResponse>> getPreSignUrl(
      @Path('resourceType') PreSignUrlType type,
      @Queries() Map<String, dynamic> queries);
}
