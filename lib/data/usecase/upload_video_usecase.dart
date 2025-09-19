import 'dart:developer';
import 'dart:io';

import 'package:flutter_bump_app/base/usecase/base_usecase.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/remote/request/video/create_video_request.dart';
import 'package:flutter_bump_app/data/remote/request/video/update_video_status_request.dart';
import 'package:flutter_bump_app/data/remote/response/video/video_response.dart';
import 'package:flutter_bump_app/data/remote/upload_ds.dart';
import 'package:flutter_bump_app/data/repository/upload/iupload_repository.dart';
import 'package:flutter_bump_app/data/repository/video/ivideo_repository.dart';
import 'package:injectable/injectable.dart';

import 'upload_usecase_mixin.dart';

class UploadVideoUseCaseParam {
  final UploadUseCaseParam uploadUseCaseParam;

  UploadVideoUseCaseParam({required this.uploadUseCaseParam});
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

      final videoModel = await videoRepository.createVideo(CreateVideoRequest(
          name: param.uploadUseCaseParam.file.path.split('/').last,
          fileUrl: preSignUrl));
      await videoRepository.updateVideo(UpdateVideoStatusRequest(
          videoId: videoModel.id, uploadStatus: UploadStatus.uploading));
      await uploadRepository.uploadFile(
          preSignUrl, param.uploadUseCaseParam.file, PreSignUrlType.video,
          onProgress: (progress, total) {
        log('Uploading: $progress/$total');
      });
      final completed = await videoRepository.updateVideo(
          UpdateVideoStatusRequest(
              videoId: videoModel.id, uploadStatus: UploadStatus.completed));
      return completed;
    } catch (e) {
      throw Exception(e);
    }
  }
}
