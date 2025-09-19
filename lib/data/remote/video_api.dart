import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_bump_app/data/remote/request/video/update_video_status_request.dart';
import 'package:flutter_bump_app/data/remote/response/video/video_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';

part 'video_api.g.dart';

@RestApi()
abstract class VideoApi {
  factory VideoApi(Dio dio, {String? baseUrl}) = _VideoApi;

  @GET('/api/videos')
  Future<PaginatedResponse<Video>> getVideos(
      @Queries() Map<String, dynamic> queries);

  @POST('/api/videos/status')
  Future<BaseResponse<Video>> updateVideoStatus(
      @Body() UpdateVideoStatusRequest request);

  @GET('/api/videos/batch/status')
  Future<BaseResponse<List<Video>>> getBatchVideoStatus(
      @Query('batchId') String batchId);

  @POST('/api/videos/batch')
  Future<BaseResponse<Video>> createVideoBatch(
      @Body() Map<String, dynamic> request);
}
