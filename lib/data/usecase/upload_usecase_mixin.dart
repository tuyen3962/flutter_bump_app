import 'dart:io';

import 'package:flutter_bump_app/base/usecase/base_usecase.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/repository/upload/iupload_repository.dart';
import 'package:injectable/injectable.dart';

class UploadUseCaseParam {
  final File file;
  final PreSignUrlType type;
  final Function(int, int)? onProgress;

  UploadUseCaseParam({
    required this.file,
    required this.type,
    this.onProgress,
  });
}

@lazySingleton
class UploadUseCaseMixin extends BaseUseCase<String, UploadUseCaseParam> {
  final IUploadRepository uploadRepository;

  UploadUseCaseMixin(this.uploadRepository);

  @override
  Future<String> call(UploadUseCaseParam param) async {
    final preSignUrl = await uploadRepository.getPreSignUrl(param.type);
    await uploadRepository.uploadFile(preSignUrl, param.file, param.type,
        onProgress: param.onProgress);
    return preSignUrl;
  }
}
