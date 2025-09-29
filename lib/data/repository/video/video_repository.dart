import 'package:flutter_bump_app/data/remote/request/video/create_video_request.dart';
import 'package:flutter_bump_app/data/remote/request/video/update_video_status_request.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/remote/response/video/video_response.dart';
import 'package:flutter_bump_app/data/remote/video_api.dart';
import 'package:injectable/injectable.dart';

import 'ivideo_repository.dart';

@Injectable(as: IVideoRepository)
class VideoRepository extends IVideoRepository {
  final VideoApi videoApi;

  VideoRepository(this.videoApi);

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
  Future<String> createBatchVideo() async {
    try {
      final response = await videoApi.createBatchUploadVideo();
      return response.data?.id ?? '';
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Video> createVideoWithBatch(CreateVideoRequest request) async {
    try {
      final response = await videoApi.createVideoWithBatch(request);
      return response.data!;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateVideoBatchStatus(
      UpdateVideoBatchStatusRequest request) async {
    try {
      final response = await videoApi.updateVideoBatchStatus(request);
      return response.isSuccess;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Video?> updateVideo(UpdateVideoStatusRequest request) async {
    try {
      final response = await videoApi.updateVideoStatus(request);
      return response.data!;
    } catch (e) {
      throw Exception(e);
    }
  }
}
