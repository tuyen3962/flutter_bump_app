import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bid_response.g.dart';

@JsonSerializable()
class PlaceBidResponse {
  final String id;
  final String creatorId;
  final String sponsorId;
  final double amount;
  final BidStatus status;
  final bool isHighestBid;
  final String createdAt;
  final String? walletTxId;
  final String? refundTxId;
  final String? message;
  final double? newBalance;
  final bool? previousBidRefunded;

  PlaceBidResponse({
    required this.id,
    required this.creatorId,
    required this.sponsorId,
    required this.amount,
    required this.status,
    required this.isHighestBid,
    required this.createdAt,
    this.walletTxId,
    this.refundTxId,
    this.message,
    this.newBalance,
    this.previousBidRefunded,
  });

  factory PlaceBidResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceBidResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceBidResponseToJson(this);
}

@JsonSerializable()
class CancelBidResponse {
  final String bidId;
  final double refundAmount;
  final String refundTxId;
  final String? message;

  CancelBidResponse(
      {required this.bidId,
      required this.refundAmount,
      required this.refundTxId,
      this.message});

  factory CancelBidResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelBidResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CancelBidResponseToJson(this);
}

@JsonSerializable()
class CreatorBidProfile {
  final String id;
  final String creatorId;
  final double minBid;
  final bool isAvailable;
  final double? currentHighestBid;
  final int completedCampaigns;
  final double? rating;
  final String createdAt;
  final String updatedAt;

  CreatorBidProfile({
    required this.id,
    required this.creatorId,
    required this.minBid,
    required this.isAvailable,
    this.currentHighestBid,
    this.completedCampaigns = 0,
    this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatorBidProfile.fromJson(Map<String, dynamic> json) =>
      _$CreatorBidProfileFromJson(json);
  Map<String, dynamic> toJson() => _$CreatorBidProfileToJson(this);
}
