import 'package:flutter_bump_app/data/model/user.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_callback_response.g.dart';

@JsonSerializable()
class GoogleCallbackResponse extends BaseResponse {
  final GoogleCallbackToken? tokens;
  final User? user;

  GoogleCallbackResponse({
    this.tokens,
    this.user,
  });

  factory GoogleCallbackResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleCallbackResponseFromJson(json);

  // Map<String, dynamic> toJson() => _$GoogleCallbackResponseToJson(this);
}

@JsonSerializable()
class GoogleCallbackToken {
  final String accessToken;
  final String refreshToken;
  // final int duration;
  // final String tokenType;

  GoogleCallbackToken({
    required this.accessToken,
    required this.refreshToken,
    // required this.duration,
    // required this.tokenType,
  });

  factory GoogleCallbackToken.fromJson(Map<String, dynamic> json) =>
      _$GoogleCallbackTokenFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleCallbackTokenToJson(this);
}

@JsonSerializable()
class PrivyCallbackToken {
  final String token;
  final int expiresIn;
  final String tokenType;
  final String userId;
  // final Map<String, dynamic> claims;
  // final String warning;

  PrivyCallbackToken({
    required this.token,
    required this.expiresIn,
    required this.tokenType,
    required this.userId,
    // required this.claims,
    // required this.warning,
  });

  factory PrivyCallbackToken.fromJson(Map<String, dynamic> json) =>
      _$PrivyCallbackTokenFromJson(json);

  Map<String, dynamic> toJson() => _$PrivyCallbackTokenToJson(this);
}
