import 'package:json_annotation/json_annotation.dart';

part 'google_mobile_login_request.g.dart';

@JsonSerializable()
class GoogleMobileLoginRequest {
  final String idToken;

  GoogleMobileLoginRequest({required this.idToken});

  factory GoogleMobileLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleMobileLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleMobileLoginRequestToJson(this);
}
