import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bid_request.g.dart';

enum GetBidSortBy { amount, createdAt, updatedAt }

@JsonSerializable()
class PlaceBidRequest {
  final String creatorId;
  final double amount;
  final Map<String, dynamic>? metadata;

  PlaceBidRequest(
      {required this.creatorId, required this.amount, this.metadata});

  factory PlaceBidRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaceBidRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceBidRequestToJson(this);
}

@JsonSerializable()
class UpdateCreatorProfileRequest {
  final double? minBid;
  final bool? isAvailable;

  UpdateCreatorProfileRequest({this.minBid, this.isAvailable});

  factory UpdateCreatorProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCreatorProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateCreatorProfileRequestToJson(this);
}

@JsonSerializable()
class GetAllBidsRequest {
  final int? page;
  final int? limit;
  final String? query;
  final GetBidSortBy? sortBy;
  final BidStatus? status;

  GetAllBidsRequest(
      {this.page, this.limit, this.query, this.sortBy, this.status});

  factory GetAllBidsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAllBidsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllBidsRequestToJson(this);
}
