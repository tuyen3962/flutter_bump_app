import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bump_app/config/constant/app_config.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/remote/response/upload/presign_response.dart';
import 'package:flutter_bump_app/data/remote/upload_ds.dart';
import 'package:flutter_bump_app/data/repository/upload/iupload_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUploadRepository)
class UploadRepository extends IUploadRepository {
  final UploadDS uploadDS;
  late final Dio _uploadDio;

  UploadRepository(this.uploadDS);

  @postConstruct
  void init() {
    _uploadDio = Dio(BaseOptions(baseUrl: AppConfig.API_URL));
    _uploadDio.interceptors.add(LogInterceptor());
  }

  @override
  Future<PreSignResponse> getPreSignUrl(
      PreSignUrlType type, String mimeType) async {
    try {
      final response = await uploadDS
          .getPreSignUrl(PreSignUrlType.video, {'miniType': mimeType});
      if (response.data == null) {
        throw Exception('PreSignResponse is null');
      }
      return response.data!;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> uploadFile(String preSignUrl, File file, PreSignUrlType type,
      {String? fileName, Function(int p1, int p2)? onProgress}) async {
    try {
      final response = await _uploadDio.put(preSignUrl,
          data: await file.readAsBytes(),
          options: Options(
            headers: {
              'Content-Type':
                  type == PreSignUrlType.video ? 'video/mp4' : 'image/png',
            },
          ), onSendProgress: (progress, total) {
        // loggerHelper.logCyan('onSendProgress: $progress/$total');
        onProgress?.call(progress, total);
      }, onReceiveProgress: (progress, total) {
        // loggerHelper.logCyan('onReceiveProgress: $progress/$total');
        onProgress?.call(progress, total);
      });
      if (response.statusCode == 200) {
        print('Uploaded successfully');
      } else {
        print('Upload failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
