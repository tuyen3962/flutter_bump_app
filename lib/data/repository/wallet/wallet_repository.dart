import 'dart:convert';

import 'package:flutter_bump_app/data/remote/wallet/wallet_api.dart';
import 'package:flutter_bump_app/data/remote/wallet/wallet_request.dart';
import 'package:flutter_bump_app/data/remote/wallet/wallet_response.dart';
import 'package:flutter_bump_app/data/repository/wallet/iwallet_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@Injectable(as: IWalletRepository)
class WalletRepository extends IWalletRepository {
  final WalletApi walletApi;

  WalletRepository(this.walletApi);

  @override
  Future<UserWalletResponse> getUserWallet() async {
    final response = await walletApi.getUserWallet();
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<WalletBalanceResponse> getWalletBalance() async {
    final response = await walletApi.getWalletBalance();
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<WalletDepositInstructionResponse>
      getWalletDepositInstructions() async {
    final response = await walletApi.getWalletDepositInstructions();
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<WithdrawResponse> withdraw(WithdrawRequest request) async {
    final response = await walletApi.withdraw(request);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<List<TransactionResponse>> getTransactions() async {
    final response = await walletApi.getTransactions();
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<double> getUSDTWithSolana(double amount) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/simple/price?ids=solana&vs_currencies=usd'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['solana']['usd'] as num).toDouble() * amount;
      } else {
        print('Failed to fetch SOL price: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching SOL price: $e');
    }
    return 0;
  }
}
