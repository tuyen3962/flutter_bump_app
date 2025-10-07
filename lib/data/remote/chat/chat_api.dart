import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/remote/chat/chat_request.dart';
import 'package:flutter_bump_app/data/remote/chat/chat_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_api.g.dart';

@RestApi()
abstract class ChatApi {
  factory ChatApi(Dio dio, {String? baseUrl}) = _ChatApi;

  @POST('/api/chat/conversations')
  Future<BaseResponse<ConversationResponse>> createConversation(
      @Body() CreateConversationRequest request);

  @GET('/api/chat/conversations')
  Future<PaginatedResponse<ConversationResponse>> getConversations();

  @GET('/api/chat/conversations/{conversationId}')
  Future<BaseResponse<ConversationResponse>> getConversationDetail(
      @Path('conversationId') String conversationId);

  @GET('/api/chat/conversations/{conversationId}/messages')
  Future<PaginatedResponse<MessageResponse>> getMessages(
      @Path('conversationId') String conversationId);

  @POST('/api/chat/conversations/{conversationId}/messages')
  Future<BaseResponse<MessageResponse>> sendMessage(
    @Path('conversationId') String conversationId,
    @Body() SendMessageRequest request,
  );

  // Mark conversation messages as read
  @POST('/api/chat/conversations/{conversationId}/read')
  Future<BaseResponse<dynamic>> markConversationRead(
      @Path('conversationId') String conversationId);

  // Delete a message
  @DELETE('/api/chat/conversations/{conversationId}/messages/{messageId}')
  Future<BaseResponse<dynamic>> deleteMessage(
    @Path('conversationId') String conversationId,
    @Path('messageId') String messageId,
  );
}
