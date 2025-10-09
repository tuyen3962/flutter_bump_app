import 'package:flutter_bump_app/data/remote/wallet/wallet_request.dart';
import 'package:flutter_bump_app/data/remote/wallet/wallet_response.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IWalletRepository extends IBaseRepository {
  Future<UserWalletResponse> getUserWallet();
  Future<WalletBalanceResponse> getWalletBalance();
  Future<WalletDepositInstructionResponse> getWalletDepositInstructions();
  Future<WithdrawResponse> withdraw(WithdrawRequest request);
  Future<List<TransactionResponse>> getTransactions();
  Future<double> getUSDTWithSolana(double amount);
}
