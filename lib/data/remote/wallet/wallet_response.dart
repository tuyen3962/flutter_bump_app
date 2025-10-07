import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_response.g.dart';

@JsonSerializable()
class UserWalletResponse {
  final String? id;
  final String? userId;
  final String? publicKey;
  final double? balance;

  UserWalletResponse({this.id, this.userId, this.publicKey, this.balance});

  factory UserWalletResponse.fromJson(Map<String, dynamic> json) =>
      _$UserWalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserWalletResponseToJson(this);
}

@JsonSerializable()
class WalletBalanceResponse {
  final double? balance;
  final String? publicKey;
  final double? onchainBalance;
  final String? lastSyncedAt;

  WalletBalanceResponse(
      {this.balance, this.publicKey, this.onchainBalance, this.lastSyncedAt});

  factory WalletBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletBalanceResponseToJson(this);
}

@JsonSerializable()
class WalletDepositInstructionResponse {
  final String? publicKey;
  final String? network;
  final List<String>? instructions;
  final String? qrCode;
  final String? explorerUrl;

  WalletDepositInstructionResponse(
      {this.publicKey,
      this.network,
      this.instructions,
      this.qrCode,
      this.explorerUrl});

  factory WalletDepositInstructionResponse.fromJson(
          Map<String, dynamic> json) =>
      _$WalletDepositInstructionResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WalletDepositInstructionResponseToJson(this);
}

@JsonSerializable()
class WithdrawResponse {
  final String? transactionId;
  final String? signature;
  final double? amount;
  final String? toAddress;
  @JsonKey(unknownEnumValue: TransactionStatus.NONE)
  final TransactionStatus? status;
  final String? message;

  WithdrawResponse(
      {this.transactionId,
      this.signature,
      this.amount,
      this.toAddress,
      this.status,
      this.message});

  factory WithdrawResponse.fromJson(Map<String, dynamic> json) =>
      _$WithdrawResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawResponseToJson(this);
}

@JsonSerializable()
class TransactionResponse {
  final String? id;
  final String? walletId;
  @JsonKey(unknownEnumValue: TransactionType.NONE)
  final TransactionType? type;
  @JsonKey(unknownEnumValue: TransactionStatus.NONE)
  final TransactionStatus? status;
  final double? amount;
  final String? signature;
  final String? fromAddress;
  final String? toAddress;
  final Map<String, dynamic>? metadata;
  final String? errorMessage;
  final String? createdAt;
  final String? completedAt;

  TransactionResponse(
      {this.id,
      this.walletId,
      this.type,
      this.status,
      this.amount,
      this.signature,
      this.fromAddress,
      this.toAddress,
      this.metadata,
      this.errorMessage,
      this.createdAt,
      this.completedAt});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}
