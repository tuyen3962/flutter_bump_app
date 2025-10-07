import 'package:json_annotation/json_annotation.dart';

part 'bid_request.g.dart';

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
