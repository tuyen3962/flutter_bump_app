import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'youtube_api.g.dart';

@RestApi()
abstract class YouTubeApi {
  factory YouTubeApi(Dio dio, {String? baseUrl}) = _YouTubeApi;

  // @POST('/api/auth/youtube/link')
  // Future<Map<String, dynamic>> initiateYouTubeLink(
  //     @Body() Map<String, dynamic> request);

  // @GET('/api/auth/youtube/callback')
  // Future<Map<String, dynamic>> youTubeCallback(
  //     @Queries() Map<String, dynamic> queries);

  // @GET('/api/auth/youtube/status')
  // Future<Map<String, dynamic>> getYouTubeStatus();

  // @POST('/api/auth/youtube/unlink')
  // Future<Map<String, dynamic>> unlinkYouTube();

  // @POST('/api/auth/videos/upload-to-youtube')
  // Future<Map<String, dynamic>> uploadVideoToYouTube(
  //     @Body() Map<String, dynamic> request);
}
