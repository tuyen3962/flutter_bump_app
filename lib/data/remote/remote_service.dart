import 'package:flutter_bump_app/config/service/provider/dio_provider.dart';
import 'package:flutter_bump_app/data/remote/upload_ds.dart';
import 'package:injectable/injectable.dart';

import 'api.dart';

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

  @lazySingleton
  UploadDS uploadDS(DioProvider provider) => UploadDS(provider.dio);

  @lazySingleton
  BidApi bidApi(DioProvider provider) => BidApi(provider.dio);

  @lazySingleton
  WalletApi walletApi(DioProvider provider) => WalletApi(provider.dio);

  @lazySingleton
  ChatApi chatApi(DioProvider provider) => ChatApi(provider.dio);

  @lazySingleton
  NotificationApi notificationApi(DioProvider provider) =>
      NotificationApi(provider.dio);

  @lazySingleton
  BrandApi brandApi(DioProvider provider) => BrandApi(provider.dio);

  @lazySingleton
  CampaignApi campaignApi(DioProvider provider) => CampaignApi(provider.dio);
}
