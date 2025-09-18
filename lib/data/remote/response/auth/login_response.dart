import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final bool? success;
  final String? message;
  final dynamic data;
  final String? deviceId;

  LoginResponse({
    this.success,
    this.message,
    this.data,
    this.deviceId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
