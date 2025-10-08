import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bid_model.g.dart';

@JsonSerializable()
class BidModel {
  final String id;
  final String creatorId;
  final String sponsorId;
  final double amount;
  final BidStatus status;
  final bool isHighestBid;
  final String? expiresAt;
  final String? walletTxId;
  final String? refundTxId;
  final Map<String, dynamic>? metadata;
  final String? createdAt;

  BidModel({
    required this.id,
    required this.creatorId,
    required this.sponsorId,
    required this.amount,
    required this.status,
    required this.isHighestBid,
    this.expiresAt,
    this.walletTxId,
    this.refundTxId,
    this.metadata,
    this.createdAt,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) =>
      _$BidModelFromJson(json);
  Map<String, dynamic> toJson() => _$BidModelToJson(this);
}
