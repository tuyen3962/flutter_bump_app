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
import '../../data/remote/authentication_api.dart' as _i665;
import '../../data/remote/highlight_api.dart' as _i217;
import '../../data/remote/upload_ds.dart' as _i818;
import '../../data/repository/account/account_repository.dart' as _i710;
import '../../data/repository/account/iaccount_repository.dart' as _i630;
import '../../data/repository/highlight/hightlight_repository.dart' as _i631;
import '../../data/repository/highlight/ihightlight_repository.dart' as _i913;
import '../../data/repository/upload/iupload_repository.dart' as _i134;
import '../../data/repository/upload/upload_repository.dart' as _i655;
import '../../data/repository/video/ivideo_repository.dart' as _i71;
import '../../data/usecase/upload_usecase_mixin.dart' as _i938;
import '../../data/usecase/upload_video_usecase.dart' as _i640;
import 'account_service.dart' as _i997;
import 'auth_service.dart' as _i184;
import 'language_service.dart' as _i313;
import 'network_service.dart' as _i39;
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
    final networkService = _$NetworkService();
    await gh.singletonAsync<_i184.AuthService>(
      () {
        final i = _i184.AuthService();
        return i.init().then((_) => i);
      },
      preResolve: true,
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
    gh.singleton<_i313.LanguageService>(
        () => _i313.LanguageService(localStorage: gh<_i845.LocalStorage>()));
    gh.factory<_i134.IUploadRepository>(
        () => _i655.UploadRepository(gh<_i818.UploadDS>())..init());
    gh.lazySingleton<_i665.AuthenticationAPI>(
        () => networkService.authenticationApiProvider(gh<_i7.DioProvider>()));
    gh.factory<_i630.IAccountRepository>(() => _i710.AccountRepository());
    gh.factory<_i913.IHighlightRepository>(
        () => _i631.HighlightRepository(gh<_i217.HighlightApi>()));
    gh.lazySingleton<_i640.UploadVideoUseCase>(() => _i640.UploadVideoUseCase(
          gh<_i71.IVideoRepository>(),
          gh<_i134.IUploadRepository>(),
        ));
    gh.lazySingleton<_i938.UploadUseCaseMixin>(
        () => _i938.UploadUseCaseMixin(gh<_i134.IUploadRepository>()));
    return this;
  }
}

class _$NetworkService extends _i39.NetworkService {}
