import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
