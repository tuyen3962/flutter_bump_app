import 'dart:io';

import 'package:flutter_bump_app/base/usecase/base_usecase.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/repository/upload/iupload_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UploadImageUsecase extends BaseUseCase<String, File> {
  final IUploadRepository uploadRepository;

  UploadImageUsecase(this.uploadRepository);

  @override
  Future<String> call(File param) async {
    final preSignUrl =
        await uploadRepository.getPreSignUrl(PreSignUrlType.image, 'image/png');
    await uploadRepository.uploadFile(
        preSignUrl.uploadUrl, param, PreSignUrlType.image);
    return preSignUrl.originURL;
  }
}
