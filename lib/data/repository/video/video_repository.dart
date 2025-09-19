import 'package:flutter_bump_app/data/remote/request/video/create_video_request.dart';
import 'package:flutter_bump_app/data/remote/request/video/update_video_status_request.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/remote/response/video/video_response.dart';
import 'package:flutter_bump_app/data/remote/video_api.dart';

import 'ivideo_repository.dart';

class VideoRepository extends IVideoRepository {
  final VideoApi videoApi;

  VideoRepository(this.videoApi);

  @override
  Future<Video> createVideo(CreateVideoRequest request) async {
    try {
      final response = await videoApi.createVideoBatch(request.toJson());
      if (response.success == true && response.data != null) {
        return response.data!;
      }
      throw Exception(response.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteVideo(String id) async {
    // try {
    //   final response = await videoApi.deleteVideo(id);
    //   if (response.success == true) {
    //     return;
    //   }
    //   throw Exception(response.message);
    // } catch (e) {
    //   throw Exception(e);
    // }
    throw Exception('Not implemented');
  }

  @override
  Future<Video> getVideo(String id) async {
    throw Exception('Not implemented');
  }

  @override
  Future<PaginatedResponse<Video>> getVideos(
      {int page = 1, int limit = 10}) async {
    try {
      final response = await videoApi.getVideos({'page': page, 'limit': limit});
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Video> updateVideo(UpdateVideoStatusRequest request) async {
    try {
      final response = await videoApi.updateVideoStatus(request);
      if (response.success == true && response.data != null) {
        return response.data!;
      }
      throw Exception(response.message);
    } catch (e) {
      throw Exception(e);
    }
  }
}
