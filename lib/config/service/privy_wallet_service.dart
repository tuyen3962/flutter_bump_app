import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/constant/app_config.dart';
import 'package:flutter_bump_app/data/repository/wallet/iwallet_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:privy_flutter/privy_flutter.dart';
import 'package:solana/solana.dart';

class WalletModel {
  double balanceSol;
  double balanceUSD;

  WalletModel({required this.balanceSol, required this.balanceUSD});

  WalletModel copyWith({double? balanceSol, double? balanceUSD}) {
    return WalletModel(
      balanceSol: balanceSol ?? this.balanceSol,
      balanceUSD: balanceUSD ?? this.balanceUSD,
    );
  }
}

@singleton
class PrivyWalletService {
  final IWalletRepository walletRepository;

  late final Privy _privy;

  PrivyWalletService(this.walletRepository);

  PrivyUser? get user => _privy.currentAuthState.user;

  final ValueNotifier<WalletModel> solanaBalance =
      ValueNotifier(WalletModel(balanceSol: 0, balanceUSD: 0));

  String get walletAddress =>
      _privy.currentAuthState.user?.embeddedSolanaWallets.first.address ?? '';

  @postConstruct
  void init() {
    _privy = Privy.init(
      config: PrivyConfig(
        appId: AppConfig.privyAppId,
        appClientId: AppConfig.privyAppClientId,
      ),
    );
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
      // await privyUser.createSolanaWallet();
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
    solanaBalance.value = WalletModel(balanceSol: 0, balanceUSD: 0);
  }

  Future<void> refreshMyWalletBalance() async {
    final result = await _privy.getUser();
    if (result?.embeddedSolanaWallets.isNotEmpty == true) {
      final client = RpcClient('https://api.devnet.solana.com');
      final lamports = await client
          .getBalance(result?.embeddedSolanaWallets.first.address ?? '');
      final sol = lamports.value / 1e9;
      final usd = await walletRepository.getUSDTWithSolana(sol);
      solanaBalance.value = WalletModel(balanceSol: sol, balanceUSD: usd);
    }
  }
}
