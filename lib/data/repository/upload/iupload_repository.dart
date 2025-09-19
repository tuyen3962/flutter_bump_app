import 'dart:io';

import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IUploadRepository extends IBaseRepository {
  Future<String> getPreSignUrl(PreSignUrlType type);

  Future<void> uploadFile(String preSignUrl, File file, PreSignUrlType type,
      {String? fileName, Function(int, int)? onProgress});

//   Future<String> uploadImage(String path, File file, {String? fileName});
//   Future<String> uploadVideo(String path, File file, {String? fileName});
//   Future<bool> delete(String path);
//   Future<List<Sticker>> getListStickers({int page = 1, int limit = 10});
}
