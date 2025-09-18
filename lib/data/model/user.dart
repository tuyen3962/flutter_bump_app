import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? name;
  String? gender;
  String? avatar;
  String? bio;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.email,
      this.name,
      this.gender,
      this.avatar,
      this.bio,
      this.createdAt,
      this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
