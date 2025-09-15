import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  String? uid;
  @JsonKey(name: 'full_name')
  String? fullName;
  String? email;
  @JsonKey(name: 'avatar_url')
  String? avatarUrl;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  @JsonKey(name: 'fcm_token')
  String? fcmToken;
  @JsonKey(name: 'background_image')
  String? backgroundImage;

  Account({
    this.uid,
    this.fullName,
    this.email,
    this.avatarUrl,
    this.phoneNumber,
    this.fcmToken,
    this.backgroundImage,
  });

  Account copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? avatarUrl,
    String? phoneNumber,
    String? fcmToken,
    String? backgroundImage,
  }) {
    return Account(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fcmToken: fcmToken ?? this.fcmToken,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
