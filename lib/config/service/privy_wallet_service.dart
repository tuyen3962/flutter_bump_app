import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/constant/app_config.dart';
import 'package:injectable/injectable.dart';
import 'package:privy_flutter/privy_flutter.dart';
import 'package:solana/solana.dart';

@singleton
class PrivyWalletService {
  late final Privy _privy;

  PrivyWalletService();

  PrivyUser? get user => _privy.currentAuthState.user;

  final ValueNotifier<double> solanaBalance = ValueNotifier(0);

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
      await privyUser.createSolanaWallet();
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

  Future<void> refreshMyWalletBalance() async {
    final result = await _privy.getUser();
    if (result?.embeddedSolanaWallets.isNotEmpty == true) {
      final client = RpcClient('https://api.devnet.solana.com');
      final lamports = await client
          .getBalance(result?.embeddedSolanaWallets.first.address ?? '');
      solanaBalance.value = lamports.value / 1e9;
    }
    print('solanaBalance: ${solanaBalance.value}');
  }
}
