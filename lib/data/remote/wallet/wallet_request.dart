import 'package:json_annotation/json_annotation.dart';

part 'wallet_request.g.dart';

@JsonSerializable()
class WithdrawRequest {
  final double amount;
  final String toAddress;
  final String memo;

  WithdrawRequest(
      {required this.amount, required this.toAddress, required this.memo});

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawRequestToJson(this);
}
