import 'dart:async';

import 'package:flutter_bump_app/base/usecase/base_usecase.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/config/service/photo_gallery_service.dart';
import 'package:flutter_bump_app/data/remote/request/video/create_video_request.dart';
import 'package:flutter_bump_app/data/remote/request/video/update_video_status_request.dart';
import 'package:flutter_bump_app/data/remote/response/video/video_response.dart';
import 'package:flutter_bump_app/data/repository/upload/iupload_repository.dart';
import 'package:flutter_bump_app/data/repository/video/ivideo_repository.dart';
import 'package:flutter_bump_app/utils/logger_helper.dart';
import 'package:injectable/injectable.dart';

class UploadVideoUseCaseParam {
  final PreSignUrlType type;
  final List<PhotoMediaAsset> assets;
  final Function(double progress)? onProgress;

  UploadVideoUseCaseParam({
    required this.type,
    required this.assets,
    this.onProgress,
  });
}

@lazySingleton
class UploadVideoWithBatchUseCase
    extends BaseUseCaseNoResult<UploadVideoUseCaseParam> {
  final IUploadRepository uploadRepository;
  final IVideoRepository videoRepository;

  UploadVideoWithBatchUseCase(this.videoRepository, this.uploadRepository);
  Timer? timer;
  // Video? _currentVideo;
  Map<String, int> videoProgress = {};

  @override
  Future<void> call(UploadVideoUseCaseParam param) async {
    try {
      videoProgress = {};
      final batchId = await videoRepository.createBatchVideo();
      if (timer != null) {
        timer?.cancel();
      }
      startTimer(batchId, param.assets.length, param.onProgress);
      await Future.wait(
          param.assets.map((asset) => uploadVideoWithBatch(batchId, asset)));
      if (timer != null) {
        timer?.cancel();
        timer = null;
      }
      loggerHelper.success('uploadVideo success');
    } catch (e) {
      if (timer != null) {
        timer?.cancel();
        timer = null;
      }
      loggerHelper.error('uploadVideo error: $e');
      throw Exception(e);
    }
  }

  Future<void> startTimer(String batchId, int totalVideos,
      Function(double progress)? onProgress) async {
    timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      // updateStatusProgress();
      loggerHelper.logCyan('update video status progress');

      await videoRepository
          .updateVideoBatchStatus(UpdateVideoBatchStatusRequest(
        batchId: batchId,
        videos: videoProgress.entries
            .map((e) => UpdateVideoStatusRequest(
                videoId: e.key,
                uploadStatus: UploadStatus.uploading,
                progress: e.value))
            .toList(),
      ));
      final totalProgress = totalVideos * 100;
      final currentProgress = videoProgress.values.reduce((a, b) => a + b);
      onProgress?.call(currentProgress / totalProgress);
    });
  }

  Future<Video?> uploadVideoWithBatch(
      String batchId, PhotoMediaAsset asset) async {
    final preSignUrl =
        await uploadRepository.getPreSignUrl(PreSignUrlType.video, 'video/mp4');
    final videoFile = await asset.assetEntity.file;
    if (videoFile == null) return null;
    final duration = asset.assetEntity.duration;
    final size = await videoFile.length();
    final videoModel = await videoRepository.createVideoWithBatch(
        CreateVideoRequest(
            name: videoFile.path.split('/').last,
            fileUrl: preSignUrl.originURL,
            batchId: batchId,
            duration: duration,
            size: size));

    await updateStatusVideo(videoModel, UploadStatus.uploading);
    await uploadRepository
        .uploadFile(preSignUrl.uploadUrl, videoFile, PreSignUrlType.video,
            onProgress: (progress, total) {
      final percent = ((progress / total) * 100).floor();

      final videoId = videoModel.id;
      if (videoProgress.containsKey(videoId)) {
        videoProgress[videoId] = percent;
      } else {
        videoProgress.putIfAbsent(videoId, () => percent);
      }
    });
    await updateStatusVideo(videoModel, UploadStatus.completed);
    loggerHelper.success('upload Video success ${preSignUrl.originURL}');
    return videoModel;
  }

  Future<void> updateStatusVideo(Video video, UploadStatus uploadStatus) async {
    loggerHelper
        .logCyan('update video ${video.id} status ${uploadStatus.name}');
    await videoRepository.updateVideo(UpdateVideoStatusRequest(
        videoId: video.id, uploadStatus: uploadStatus));
  }
}
