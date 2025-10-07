import 'package:flutter_bump_app/data/remote/chat/chat_request.dart';
import 'package:flutter_bump_app/data/remote/chat/chat_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IChatRepository extends IBaseRepository {
  Future<ConversationResponse> createConversation(
      CreateConversationRequest request);

  Future<PaginatedResponse<ConversationResponse>> getConversations(
      {int page = 1, int limit = 20});

  Future<ConversationResponse> getConversationDetail(String conversationId);

  Future<PaginatedResponse<MessageResponse>> getMessages(String conversationId,
      {int page = 1, int limit = 50});

  Future<MessageResponse> sendMessage(
      String conversationId, SendMessageRequest request);

  Future<void> markConversationRead(String conversationId);

  Future<void> deleteMessage(String conversationId, String messageId);
}
