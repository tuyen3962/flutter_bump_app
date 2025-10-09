import 'package:json_annotation/json_annotation.dart';

import '../enum/app_enum.dart';

part 'creator_model.g.dart';

@JsonSerializable()
class CreatorModel {
  String? id;
  String? username;
  String? avatar;
  List<String>? niche;
  int? rating;
  bool? verified;
  int? followers;
  int? totalViews;
  int? sponsorships;
  double? minBid;
  bool? isAvailable;
  bool? isMyBid;
  BidStatus? bidStatus;

  CreatorModel({
    this.id,
    this.username,
    this.avatar,
    this.niche,
    this.rating,
    this.verified,
    this.followers,
    this.totalViews,
    this.sponsorships,
    this.minBid,
    this.isAvailable,
    this.isMyBid,
    this.bidStatus,
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorModelToJson(this);
}
