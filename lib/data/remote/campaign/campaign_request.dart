import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_request.g.dart';

@JsonSerializable()
class FilterCampaignRequest {
  final int page;
  final int limit;
  final String? query;
  final CampaignStatus? status;

  FilterCampaignRequest({
    this.page = 1,
    this.limit = 10,
    this.query,
    this.status,
  });

  factory FilterCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$FilterCampaignRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final json = _$FilterCampaignRequestToJson(this);
    json.removeWhere((key, value) => value == null || value == '');
    return json;
  }
}

@JsonSerializable()
class UpdateCampaignRequest {
  String? name;
  String? description;
  String? logo;
  String? banner;
  int? durationLimit;
  String? startDate;
  String? endDate;
  int? budget;
  List<SocialLinks>? socialLinks;
  List<Requirements>? requirements;
  CampaignStatus? status;

  UpdateCampaignRequest(
      {this.name,
      this.description,
      this.logo,
      this.banner,
      this.durationLimit,
      this.startDate,
      this.endDate,
      this.budget,
      this.socialLinks,
      this.requirements,
      this.status});

  factory UpdateCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCampaignRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final json = _$UpdateCampaignRequestToJson(this);
    json.removeWhere((key, value) => value == null || value == '');
    return json;
  }

  UpdateCampaignRequest copyWith({
    String? name,
    String? description,
    String? logo,
    String? banner,
    int? durationLimit,
    String? startDate,
    String? endDate,
    int? budget,
    List<SocialLinks>? socialLinks,
    List<Requirements>? requirements,
    CampaignStatus? status,
  }) =>
      UpdateCampaignRequest(
          name: name ?? this.name,
          description: description ?? this.description,
          logo: logo ?? this.logo,
          banner: banner ?? this.banner,
          durationLimit: durationLimit ?? this.durationLimit,
          startDate: startDate ?? this.startDate,
          endDate: endDate ?? this.endDate,
          budget: budget ?? this.budget,
          socialLinks: socialLinks ?? this.socialLinks,
          requirements: requirements ?? this.requirements,
          status: status ?? this.status);
}

@JsonSerializable()
class SocialLinks {
  String? type;
  String? value;

  SocialLinks({this.type, this.value});

  factory SocialLinks.fromJson(Map<String, dynamic> json) =>
      _$SocialLinksFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinksToJson(this);
}

@JsonSerializable()
class Requirements {
  String? label;
  bool? isMandatory;

  Requirements({this.label, this.isMandatory});

  factory Requirements.fromJson(Map<String, dynamic> json) =>
      _$RequirementsFromJson(json);

  Map<String, dynamic> toJson() => _$RequirementsToJson(this);
}
