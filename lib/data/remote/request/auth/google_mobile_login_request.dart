import 'package:flutter_bump_app/data/model/device_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_mobile_login_request.g.dart';

@JsonSerializable()
class GoogleMobileLoginRequest {
  final String idToken;
  @JsonKey(name: 'device_info')
  final DeviceModel device;

  GoogleMobileLoginRequest({required this.idToken, required this.device});

  factory GoogleMobileLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleMobileLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleMobileLoginRequestToJson(this);
}
