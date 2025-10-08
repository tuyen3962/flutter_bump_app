import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/privy_wallet_service.dart';
import 'package:flutter_bump_app/data/local/local_storage.dart';
import 'package:flutter_bump_app/data/repository/account/iaccount_repository.dart';

import 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  final AccountService accountService;
  final LocalStorage localStorage;
  final IAccountRepository accountRepository;
  final PrivyWalletService privyWalletService;

  SplashCubit({
    required this.accountService,
    required this.localStorage,
    required this.accountRepository,
    required this.privyWalletService,
  }) : super(const SplashState());

  void initializeSplash() async {
    final isLoggedIn = await _checkAuthentication();

    emit(state.copyWith(isLoggedIn: isLoggedIn));
  }

  Future<bool> _checkAuthentication() async {
    try {
      final token = await localStorage.accessToken();
      if (token != null) {
        final user = await accountRepository.getUserProfile();
        if (user == null) {
          return false;
        }
        accountService.setAccount(user);
        privyWalletService.refreshMyWalletBalance();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
