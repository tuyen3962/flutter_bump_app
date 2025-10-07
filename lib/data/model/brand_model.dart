import 'package:json_annotation/json_annotation.dart';

part 'brand_model.g.dart';

@JsonSerializable()
class BrandModel {
  String? id;
  String? name;
  String? logo;
  @JsonKey(name: 'created_at')
  String? createdAt;

  BrandModel({this.id, this.name, this.logo, this.createdAt});

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}
