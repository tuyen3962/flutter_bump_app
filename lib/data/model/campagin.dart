import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campagin.g.dart';

@JsonSerializable()
class CampaignModel {
  String? id;
  String? creatorId;
  String? sponsorId;
  @JsonKey(unknownEnumValue: CampaignStatus.PENDING)
  CampaignStatus? status;
  CampaignCreator? creator;
  double? budget;
  String? startDate;
  String? endDate;
  // Map<String, dynamic>? metadata;
  String? createdAt;
  String? logo;
  String? banner;
  @JsonKey(fromJson: parseNumber)
  int? views;
  @JsonKey(fromJson: parseNumber)
  int? likes;
  @JsonKey(fromJson: parseNumber)
  int? shares;
  @JsonKey(fromJson: parseNumber)
  int? comments;
  List<SocialLink>? socialLinks;

  List<SocialLinkType> get socialLinkTypes =>
      socialLinks?.map((e) => e.type ?? SocialLinkType.WEBSITE).toList() ?? [];

  static parseNumber(dynamic json) {
    if (json is num) {
      return json;
    } else if (json is String) {
      return int.tryParse(json) ?? 0;
    }
    return 0;
  }

  CampaignModel(
      {this.id,
      this.creatorId,
      this.sponsorId,
      this.status,
      this.creator,
      this.budget,
      this.startDate,
      this.endDate,
      // this.metadata,
      this.createdAt,
      this.logo,
      this.banner,
      this.views,
      this.likes,
      this.shares,
      this.comments,
      this.socialLinks});

  factory CampaignModel.fromJson(Map<String, dynamic> json) =>
      _$CampaignModelFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignModelToJson(this);
}

@JsonSerializable()
class CampaignCreator {
  String? id;
  String? username;
  String? email;
  String? name;
  @JsonKey(unknownEnumValue: Gender.OTHER)
  Gender? gender;
  List<CampaignExpertises>? expertises;
  String? avatar;
  String? bio;
  @JsonKey(unknownEnumValue: CreatorRole.CREATOR)
  CreatorRole? type;
  String? createdAt;

  CampaignCreator(
      {this.id,
      this.username,
      this.email,
      this.name,
      this.gender,
      this.expertises,
      this.avatar,
      this.bio,
      this.type,
      this.createdAt});

  factory CampaignCreator.fromJson(Map<String, dynamic> json) =>
      _$CampaignCreatorFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignCreatorToJson(this);
}

@JsonSerializable()
class CampaignExpertises {
  String? userId;
  String? expertiseId;
  Expertise? expertise;

  CampaignExpertises({this.userId, this.expertiseId, this.expertise});

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['userId'] = this.userId;
  //   data['expertiseId'] = this.expertiseId;
  //   if (this.expertise != null) {
  //     data['expertise'] = this.expertise!.toJson();
  //   }
  //   return data;
  // }

  factory CampaignExpertises.fromJson(Map<String, dynamic> json) =>
      _$CampaignExpertisesFromJson(json);
  Map<String, dynamic> toJson() => _$CampaignExpertisesToJson(this);
}

@JsonSerializable()
class Expertise {
  String? id;
  String? name;
  String? createdAt;

  Expertise({this.id, this.name, this.createdAt});

  factory Expertise.fromJson(Map<String, dynamic> json) =>
      _$ExpertiseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpertiseToJson(this);
}

@JsonSerializable()
class SocialLink {
  @JsonKey(unknownEnumValue: SocialLinkType.WEBSITE)
  SocialLinkType? type;
  String? value;

  SocialLink({this.type, this.value});

  factory SocialLink.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinkToJson(this);
}
