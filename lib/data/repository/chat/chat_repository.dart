import 'package:flutter_bump_app/data/remote/chat/chat_api.dart';
import 'package:flutter_bump_app/data/remote/chat/chat_request.dart';
import 'package:flutter_bump_app/data/remote/chat/chat_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/chat/ichat_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IChatRepository)
class ChatRepository extends IChatRepository {
  final ChatApi chatApi;

  ChatRepository(this.chatApi);

  @override
  Future<ConversationResponse> createConversation(
      CreateConversationRequest request) async {
    final response = await chatApi.createConversation(request);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<PaginatedResponse<ConversationResponse>> getConversations(
      {int page = 1, int limit = 20}) async {
    // Assuming backend supports page & limit via query
    return await chatApi.getConversations();
  }

  @override
  Future<ConversationResponse> getConversationDetail(
      String conversationId) async {
    final response = await chatApi.getConversationDetail(conversationId);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<PaginatedResponse<MessageResponse>> getMessages(String conversationId,
      {int page = 1, int limit = 50}) async {
    // Assuming backend supports pagination via default values
    return await chatApi.getMessages(conversationId);
  }

  @override
  Future<MessageResponse> sendMessage(
      String conversationId, SendMessageRequest request) async {
    final response = await chatApi.sendMessage(conversationId, request);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<void> markConversationRead(String conversationId) async {
    final response = await chatApi.markConversationRead(conversationId);
    if (response.isSuccess) {
      return;
    }
    throw Exception(response.message);
  }

  @override
  Future<void> deleteMessage(String conversationId, String messageId) async {
    final response = await chatApi.deleteMessage(conversationId, messageId);
    if (response.isSuccess) {
      return;
    }
    throw Exception(response.message);
  }
}
