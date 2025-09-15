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
import '../../data/repository/account/account_repository.dart' as _i710;
import '../../data/repository/account/iaccount_repository.dart' as _i630;
import '../../data/repository/upload/iupload_repository.dart' as _i134;
import '../../data/repository/upload/upload_repository.dart' as _i655;
import 'account_service.dart' as _i997;
import 'language_service.dart' as _i313;
import 'manage_app_service.dart' as _i479;
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
    gh.factory<_i479.ManageAppService>(() => _i479.ManageAppService());
    gh.lazySingleton<_i7.DioProvider>(() => _i7.DioProvider());
    gh.factory<_i134.IUploadRepository>(() => _i655.UploadRepository());
    await gh.singletonAsync<_i845.LocalStorage>(
      () {
        final i = _i845.LocalStorageImpl();
        return i.onInitService().then((_) => i);
      },
      preResolve: true,
    );
    gh.lazySingleton<_i665.AuthenticationAPI>(
        () => networkService.authenticationApiProvider(gh<_i7.DioProvider>()));
    gh.factory<_i630.IAccountRepository>(() => _i710.AccountRepository());
    gh.singleton<_i313.LanguageService>(
        () => _i313.LanguageService(localStorage: gh<_i845.LocalStorage>()));
    gh.factory<_i997.AccountService>(
        () => _i997.AccountService(storageService: gh<_i845.LocalStorage>()));
    return this;
  }
}

class _$NetworkService extends _i39.NetworkService {}
