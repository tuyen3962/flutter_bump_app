import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? name;
  UserGender? gender;
  String? avatar;
  String? bio;
  bool? emailVerified;

  User({
    this.id,
    this.email,
    this.name,
    this.gender,
    this.avatar,
    this.bio,
    this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
