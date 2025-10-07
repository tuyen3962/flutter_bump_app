// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/local/local_storage.dart' as _i845;
import '../../data/remote/api.dart' as _i692;
import '../../data/remote/auth_api.dart' as _i227;
import '../../data/remote/bid/bid_api.dart' as _i150;
import '../../data/remote/brand_api.dart' as _i107;
import '../../data/remote/chat/chat_api.dart' as _i819;
import '../../data/remote/highlight_api.dart' as _i217;
import '../../data/remote/notification/notification_api.dart' as _i143;
import '../../data/remote/remote_service.dart' as _i960;
import '../../data/remote/upload_ds.dart' as _i818;
import '../../data/remote/user_api.dart' as _i925;
import '../../data/remote/video_api.dart' as _i765;
import '../../data/remote/wallet/wallet_api.dart' as _i869;
import '../../data/repository/account/account_repository.dart' as _i710;
import '../../data/repository/account/iaccount_repository.dart' as _i630;
import '../../data/repository/auth/auth_repository.dart' as _i214;
import '../../data/repository/auth/iauth_repository.dart' as _i649;
import '../../data/repository/bid/bid_repository.dart' as _i958;
import '../../data/repository/bid/ibid_repository.dart' as _i174;
import '../../data/repository/brand/brand_repository.dart' as _i386;
import '../../data/repository/brand/ibrand_repository.dart' as _i781;
import '../../data/repository/chat/chat_repository.dart' as _i233;
import '../../data/repository/chat/ichat_repository.dart' as _i841;
import '../../data/repository/highlight/hightlight_repository.dart' as _i631;
import '../../data/repository/highlight/ihightlight_repository.dart' as _i913;
import '../../data/repository/notification/inotification_repository.dart'
    as _i705;
import '../../data/repository/notification/notification_repository.dart'
    as _i748;
import '../../data/repository/upload/iupload_repository.dart' as _i134;
import '../../data/repository/upload/upload_repository.dart' as _i655;
import '../../data/repository/video/ivideo_repository.dart' as _i71;
import '../../data/repository/video/video_repository.dart' as _i944;
import '../../data/repository/wallet/iwallet_repository.dart' as _i998;
import '../../data/repository/wallet/wallet_repository.dart' as _i885;
import '../../data/usecase/upload_video_with_batch_usecase.dart' as _i722;
import 'account_service.dart' as _i997;
import 'auth_service.dart' as _i184;
import 'language_service.dart' as _i313;
import 'photo_gallery_service.dart' as _i364;
import 'privy_wallet_service.dart' as _i796;
import 'profile_servide.dart' as _i709;
import 'provider/dio_provider.dart' as _i7;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final remoteService = _$RemoteService();
    gh.factory<_i796.PrivyWalletService>(
        () => _i796.PrivyWalletService()..init());
    gh.singleton<_i364.PhotoGalleryService>(
      () => _i364.PhotoGalleryService(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i7.DioProvider>(() => _i7.DioProvider());
    await gh.singletonAsync<_i845.LocalStorage>(
      () {
        final i = _i845.LocalStorageImpl();
        return i.onInitService().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i997.AccountService>(
        () => _i997.AccountService(storageService: gh<_i845.LocalStorage>()));
    gh.factory<_i781.IBrandRepository>(
        () => _i386.BrandRepository(gh<_i107.BrandApi>()));
    gh.singleton<_i313.LanguageService>(
        () => _i313.LanguageService(localStorage: gh<_i845.LocalStorage>()));
    gh.lazySingleton<_i692.AuthApi>(
        () => remoteService.authApi(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i692.UserApi>(
        () => remoteService.userApi(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i692.VideoApi>(
        () => remoteService.videoApi(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i692.YouTubeApi>(
        () => remoteService.youTubeApi(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i692.HighlightApi>(
        () => remoteService.highlightApi(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i818.UploadDS>(
        () => remoteService.uploadDS(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i692.BidApi>(
        () => remoteService.bidApi(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i692.WalletApi>(
        () => remoteService.walletApi(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i692.ChatApi>(
        () => remoteService.chatApi(gh<_i7.DioProvider>()));
    gh.lazySingleton<_i692.NotificationApi>(
        () => remoteService.notificationApi(gh<_i7.DioProvider>()));
    gh.factory<_i998.IWalletRepository>(
        () => _i885.WalletRepository(gh<_i869.WalletApi>()));
    gh.factory<_i649.IAuthRepository>(() => _i214.AuthRepository(
          gh<_i227.AuthApi>(),
          gh<_i845.LocalStorage>(),
        ));
    gh.factory<_i71.IVideoRepository>(
        () => _i944.VideoRepository(gh<_i765.VideoApi>()));
    gh.factory<_i913.IHighlightRepository>(
        () => _i631.HighlightRepository(gh<_i217.HighlightApi>()));
    gh.factory<_i174.IBidRepository>(
        () => _i958.BidRepository(gh<_i150.BidApi>()));
    gh.factory<_i630.IAccountRepository>(
        () => _i710.AccountRepository(gh<_i925.UserApi>()));
    gh.factory<_i841.IChatRepository>(
        () => _i233.ChatRepository(gh<_i819.ChatApi>()));
    gh.factory<_i705.INotificationRepository>(
        () => _i748.NotificationRepository(gh<_i143.NotificationApi>()));
    gh.factory<_i134.IUploadRepository>(
        () => _i655.UploadRepository(gh<_i818.UploadDS>())..init());
    gh.singleton<_i709.ProfileServide>(() => _i709.ProfileServide(
          accountService: gh<_i997.AccountService>(),
          accountRepository: gh<_i630.IAccountRepository>(),
        ));
    await gh.singletonAsync<_i184.AuthService>(
      () {
        final i = _i184.AuthService(
          privyWalletService: gh<_i796.PrivyWalletService>(),
          authRepository: gh<_i649.IAuthRepository>(),
          accountService: gh<_i997.AccountService>(),
          accountRepository: gh<_i630.IAccountRepository>(),
        );
        return i.init().then((_) => i);
      },
      preResolve: true,
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i722.UploadVideoWithBatchUseCase>(
        () => _i722.UploadVideoWithBatchUseCase(
              gh<_i71.IVideoRepository>(),
              gh<_i134.IUploadRepository>(),
            ));
    return this;
  }
}

class _$RemoteService extends _i960.RemoteService {}
