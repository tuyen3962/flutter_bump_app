import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:flutter_bump_app/config/model/sticker.dart';
import 'package:flutter_bump_app/data/repository/upload/iupload_repository.dart';

@Injectable(as: IUploadRepository)
class UploadRepository extends IUploadRepository {
  UploadRepository();

  @override
  Future<bool> delete(String path) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Sticker>> getListStickers({int page = 1, int limit = 10}) {
    // TODO: implement getListStickers
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImage(String path, File file, {String? fileName}) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<String> uploadVideo(String path, File file, {String? fileName}) {
    // TODO: implement uploadVideo
    throw UnimplementedError();
  }
}
