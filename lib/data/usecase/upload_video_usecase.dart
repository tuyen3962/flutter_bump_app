import 'package:flutter_bump_app/base/usecase/base_usecase.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/remote/request/video/create_video_request.dart';
import 'package:flutter_bump_app/data/remote/request/video/update_video_status_request.dart';
import 'package:flutter_bump_app/data/remote/response/video/video_response.dart';
import 'package:flutter_bump_app/data/repository/upload/iupload_repository.dart';
import 'package:flutter_bump_app/data/repository/video/ivideo_repository.dart';
import 'package:flutter_bump_app/utils/logger_helper.dart';
import 'package:injectable/injectable.dart';

import 'upload_usecase_mixin.dart';

class UploadVideoUseCaseParam {
  final UploadUseCaseParam uploadUseCaseParam;
  final Function(int progress, int total)? onProgress;

  UploadVideoUseCaseParam({
    required this.uploadUseCaseParam,
    this.onProgress,
  });
}

@lazySingleton
class UploadVideoUseCase extends BaseUseCase<Video, UploadVideoUseCaseParam> {
  final IUploadRepository uploadRepository;
  final IVideoRepository videoRepository;

  UploadVideoUseCase(this.videoRepository, this.uploadRepository);

  @override
  Future<Video> call(UploadVideoUseCaseParam param) async {
    try {
      final preSignUrl =
          await uploadRepository.getPreSignUrl(PreSignUrlType.video);
      loggerHelper.logCyan('preSignUrl: $preSignUrl');
      final videoModel = await videoRepository.createVideo(CreateVideoRequest(
          name: param.uploadUseCaseParam.file.path.split('/').last,
          fileUrl: preSignUrl));
      loggerHelper.logCyan('create video success');
      await videoRepository.updateVideo(UpdateVideoStatusRequest(
          videoId: videoModel.id, uploadStatus: UploadStatus.uploading));
      loggerHelper.logCyan('updateVideoStatus success');
      await uploadRepository.uploadFile(
          preSignUrl, param.uploadUseCaseParam.file, PreSignUrlType.video,
          onProgress: param.onProgress ??
              (progress, total) {
                param.onProgress?.call(progress, total);
                // loggerHelper.success('Uploading: $progress/$total');
              });
      final completed = await videoRepository.updateVideo(
          UpdateVideoStatusRequest(
              videoId: videoModel.id, uploadStatus: UploadStatus.completed));
      loggerHelper.logCyan('updateVideoStatus completed');
      return completed!;
    } catch (e) {
      loggerHelper.error('uploadVideo error: $e');
      throw Exception(e);
    }
  }
}
