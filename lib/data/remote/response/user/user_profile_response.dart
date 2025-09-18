import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

enum Gender {
  @JsonValue('MALE')
  male,
  @JsonValue('FEMALE')
  female,
  @JsonValue('OTHER')
  other,
}

@JsonSerializable()
class UserProfile {
  final String id;
  final String email;
  final String? name;
  final Gender? gender;
  final String? avatar;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.email,
    this.name,
    this.gender,
    this.avatar,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
