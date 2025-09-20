import 'package:flutter_bump_app/data/local/local_storage.dart';
import 'package:flutter_bump_app/data/remote/auth_api.dart';
import 'package:flutter_bump_app/data/remote/request/auth/google_mobile_login_request.dart';
import 'package:injectable/injectable.dart';

import 'iauth_repository.dart';

@Injectable(as: IAuthRepository)
class AuthRepository extends IAuthRepository {
  AuthRepository(this.api, this.localStorage);

  final LocalStorage localStorage;
  final AuthApi api;

  @override
  Future<bool> googleMobileLogin(GoogleMobileLoginRequest request) async {
    try {
      final response = await api.googleMobileLogin(request);
      if (response.isSuccess) {
        final tokens = response.data;
        await Future.wait([
          localStorage.cacheAccessToken(tokens?.accessToken ?? ''),
          localStorage.cacheRefreshToken(tokens?.refreshToken ?? ''),
          // localStorage.cacheUserID(response.user?.id ?? ''),
          // localStorage.saveValue(keyTokenType, tokens?.tokenType ?? '')
        ]);
        return response.data != null;
      }
      return false;
    } catch (e) {
      handleError(e);
      return false;
    }
  }
}
