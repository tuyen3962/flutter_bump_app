import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'wallet_request.dart';
import 'wallet_response.dart';

part 'wallet_api.g.dart';

@RestApi()
abstract class WalletApi {
  factory WalletApi(Dio dio, {String? baseUrl}) = _WalletApi;

  @GET('/api/wallets')
  Future<BaseResponse<UserWalletResponse>> getUserWallet();

  @GET('/api/wallets/balance')
  Future<BaseResponse<WalletBalanceResponse>> getWalletBalance();

  @GET('/api/wallets/deposit-instructions')
  Future<BaseResponse<WalletDepositInstructionResponse>>
      getWalletDepositInstructions();

  @POST('/api/wallets/withdraw')
  Future<BaseResponse<WithdrawResponse>> withdraw(
      @Body() WithdrawRequest request);

  @GET('/api/wallets/transactions')
  Future<BaseResponse<List<TransactionResponse>>> getTransactions();
}
