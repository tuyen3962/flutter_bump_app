import 'package:json_annotation/json_annotation.dart';

part 'google_callback_response.g.dart';

@JsonSerializable()
class GoogleCallbackUser {
  final String id;
  final String email;
  final String? name;
  final String? gender;
  final DateTime createdAt;
  final DateTime updatedAt;

  GoogleCallbackUser({
    required this.id,
    required this.email,
    this.name,
    this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GoogleCallbackUser.fromJson(Map<String, dynamic> json) =>
      _$GoogleCallbackUserFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleCallbackUserToJson(this);
}

@JsonSerializable()
class GoogleCallbackResponse {
  final String accessToken;
  final String refreshToken;
  final GoogleCallbackUser user;

  GoogleCallbackResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory GoogleCallbackResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleCallbackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleCallbackResponseToJson(this);
}
