import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'notification_response.dart';

part 'notification_api.g.dart';

@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio, {String? baseUrl}) = _NotificationApi;

  // List notifications (paginated)
  @GET('/api/notifications')
  Future<PaginatedResponse<AppNotification>> getNotifications(
      {@Queries() Map<String, dynamic>? queries});

  // Get a notification detail
  @GET('/api/notifications/{id}')
  Future<BaseResponse<AppNotification>> getNotification(@Path('id') String id);

  // Mark a single notification as read
  @POST('/api/notifications/{id}/read')
  Future<BaseResponse<dynamic>> markRead(@Path('id') String id);

  // Mark all notifications as read
  @POST('/api/notifications/read-all')
  Future<BaseResponse<dynamic>> markAllRead();

  // Delete a notification
  @DELETE('/api/notifications/{id}')
  Future<BaseResponse<dynamic>> deleteNotification(@Path('id') String id);
}
