import 'package:flutter_bump_app/base/usecase/base_usecase.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/privy_wallet_service.dart';
import 'package:flutter_bump_app/data/local/local_storage.dart';
import 'package:flutter_bump_app/data/repository/account/iaccount_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUsecase extends BaseNormalUseCase {
  final IAccountRepository accountRepository;
  final LocalStorage localStorage;
  final AccountService accountService;
  final PrivyWalletService privyWalletService;

  LogoutUsecase(this.accountRepository, this.localStorage, this.accountService,
      this.privyWalletService);

  @override
  Future<void> call() async {
    await accountRepository.logout();
    await localStorage.clear();
    accountService.setAccount(null);
    privyWalletService.logout();
  }
}
