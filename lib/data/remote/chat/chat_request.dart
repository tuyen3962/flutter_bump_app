import 'package:json_annotation/json_annotation.dart';

part 'chat_request.g.dart';

@JsonSerializable()
class CreateConversationRequest {
  final List<String> participantIds;

  CreateConversationRequest({required this.participantIds});

  factory CreateConversationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateConversationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateConversationRequestToJson(this);
}

@JsonSerializable()
class SendMessageRequest {
  final String content;
  final String? replyToId;

  SendMessageRequest({required this.content, this.replyToId});

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
