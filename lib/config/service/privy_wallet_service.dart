import 'package:flutter_bump_app/config/constant/app_config.dart';
import 'package:injectable/injectable.dart';
import 'package:privy_flutter/privy_flutter.dart';

@injectable
class PrivyWalletService {
  late final Privy _privy;

  PrivyWalletService();

  // PrivyUser? _user;
  PrivyUser? get user => _privy.currentAuthState.user;

  @postConstruct
  void init() {
    _privy = Privy.init(
        config: PrivyConfig(
            appId: AppConfig.privyAppId,
            appClientId: AppConfig.privyAppClientId));
  }

  Future<String> loginWithGoogle() async {
    final result = await _privy.oAuth.login(
      provider: OAuthProvider.google,
      appUrlScheme: AppConfig.privyAppUrlScheme,
    );
    if (result is Success) {
      final success = result as Success<PrivyUser>;
      final privyUser = success.value;
      final accessToken = await privyUser.getAccessToken();
      // privyUser.
      if (accessToken is Success) {
        return (accessToken as Success<String>).value;
      }
    }
    if (result is Failure) {
      print('loginWithGoogle error:');
    }
    return '';
  }

  Future<void> logout() async {
    await _privy.logout();
  }
}
