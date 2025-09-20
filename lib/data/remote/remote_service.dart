import 'package:flutter_bump_app/config/service/provider/dio_provider.dart';
import 'package:flutter_bump_app/data/remote/auth_api.dart';
import 'package:flutter_bump_app/data/remote/highlight_api.dart';
import 'package:flutter_bump_app/data/remote/user_api.dart';
import 'package:flutter_bump_app/data/remote/video_api.dart';
import 'package:flutter_bump_app/data/remote/youtube_api.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RemoteService {
  @lazySingleton
  AuthApi authApi(DioProvider provider) => AuthApi(provider.dio);

  @lazySingleton
  UserApi userApi(DioProvider provider) => UserApi(provider.dio);

  @lazySingleton
  VideoApi videoApi(DioProvider provider) => VideoApi(provider.dio);

  @lazySingleton
  YouTubeApi youTubeApi(DioProvider provider) => YouTubeApi(provider.dio);

  @lazySingleton
  HighlightApi highlightApi(DioProvider provider) => HighlightApi(provider.dio);
}
