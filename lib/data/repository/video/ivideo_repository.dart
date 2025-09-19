import 'package:flutter_bump_app/data/remote/request/video/create_video_request.dart';
import 'package:flutter_bump_app/data/remote/request/video/update_video_status_request.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/remote/response/video/video_response.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IVideoRepository extends IBaseRepository {
  Future<PaginatedResponse<Video>> getVideos({int page = 1, int limit = 10});

  Future<Video> getVideo(String id);

  Future<Video> createVideo(CreateVideoRequest request);

  Future<Video> updateVideo(UpdateVideoStatusRequest request);

  Future<void> deleteVideo(String id);
}
