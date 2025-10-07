import 'package:json_annotation/json_annotation.dart';

part 'chat_response.g.dart';

@JsonSerializable()
class ConversationResponse {
  final String id;
  final String whoStartedId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String? lastMessageId;
  final MessageResponse? lastMessage;
  final List<ConversationParticipant> participants;
  final int? unreadCount;

  ConversationResponse({
    required this.id,
    required this.whoStartedId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.lastMessageId,
    this.lastMessage,
    required this.participants,
    this.unreadCount,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationResponseToJson(this);
}

@JsonSerializable()
class ConversationParticipant {
  final String id;
  final String userId;
  final SimpleUser user;
  final String createdAt;

  ConversationParticipant(
      {required this.id,
      required this.userId,
      required this.user,
      required this.createdAt});

  factory ConversationParticipant.fromJson(Map<String, dynamic> json) =>
      _$ConversationParticipantFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationParticipantToJson(this);
}

@JsonSerializable()
class SimpleUser {
  final String id;
  final String name;
  final String? avatar;

  SimpleUser({required this.id, required this.name, this.avatar});

  factory SimpleUser.fromJson(Map<String, dynamic> json) =>
      _$SimpleUserFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleUserToJson(this);
}

@JsonSerializable()
class MessageResponse {
  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final SimpleUser? sender;
  final List<ReadReceipt>? readBy;

  MessageResponse({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.sender,
    this.readBy,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);
}

@JsonSerializable()
class ReadReceipt {
  final String userId;
  final String? readAt;

  ReadReceipt({required this.userId, this.readAt});

  factory ReadReceipt.fromJson(Map<String, dynamic> json) =>
      _$ReadReceiptFromJson(json);
  Map<String, dynamic> toJson() => _$ReadReceiptToJson(this);
}

@JsonSerializable()
class ChatOperationResponse {
  final bool success;
  final String? message;
  final Map<String, dynamic>? data;

  ChatOperationResponse({required this.success, this.message, this.data});

  factory ChatOperationResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatOperationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChatOperationResponseToJson(this);
}
