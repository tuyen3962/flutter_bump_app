import 'package:json_annotation/json_annotation.dart';
import '../../response/user/user_profile_response.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  final String? name;
  final String? bio;
  final Gender? gender;
  final String? avatar;

  UpdateProfileRequest({
    this.name,
    this.bio,
    this.gender,
    this.avatar,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
