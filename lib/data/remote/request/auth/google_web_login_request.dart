import 'package:json_annotation/json_annotation.dart';

part 'google_web_login_request.g.dart';

enum GoogleSelectBy {
  @JsonValue('auto')
  auto,
  @JsonValue('user')
  user,
  @JsonValue('user_1tap')
  user1tap,
  @JsonValue('user_2tap')
  user2tap,
  @JsonValue('btn')
  btn,
  @JsonValue('btn_confirm')
  btnConfirm,
  @JsonValue('btn_add_session')
  btnAddSession,
  @JsonValue('btn_confirm_add_session')
  btnConfirmAddSession,
}

@JsonSerializable()
class GoogleWebLoginRequest {
  final String credential;
  final String? clientId;
  @JsonKey(name: 'select_by')
  final GoogleSelectBy? selectBy;

  GoogleWebLoginRequest({
    required this.credential,
    this.clientId,
    this.selectBy,
  });

  factory GoogleWebLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleWebLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleWebLoginRequestToJson(this);
}
