import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeviceModel {
  final String deviceId;
  final String platform;
  final String version;

  DeviceModel({
    required this.deviceId,
    required this.platform,
    required this.version,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceInfo': deviceId,
      'platform': platform,
      'version': version,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      // brand: map['brand'] as String,
      // deviceModel: map['deviceModel'] as String,
      deviceId: map['deviceInfo'] as String,
      platform: map['platform'] as String,
      version: map['version'] as String,
      // deviceName: map['deviceName'] as String,
      // systemName: map['systemName'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  Map<String, dynamic> toJson() => toMap();

  factory DeviceModel.fromJson(String source) =>
      DeviceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
