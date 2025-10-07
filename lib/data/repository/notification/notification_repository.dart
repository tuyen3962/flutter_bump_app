import 'package:flutter_bump_app/data/remote/notification/notification_api.dart';
import 'package:flutter_bump_app/data/remote/notification/notification_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/notification/inotification_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: INotificationRepository)
class NotificationRepository extends INotificationRepository {
  final NotificationApi notificationApi;

  NotificationRepository(this.notificationApi);

  @override
  Future<PaginatedResponse<AppNotification>> getNotifications(
      {int page = 1, int limit = 20}) async {
    return await notificationApi
        .getNotifications(queries: {'page': page, 'limit': limit});
  }

  @override
  Future<AppNotification> getNotification(String id) async {
    final response = await notificationApi.getNotification(id);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<void> markRead(String id) async {
    final response = await notificationApi.markRead(id);
    if (response.isSuccess) {
      return;
    }
    throw Exception(response.message);
  }

  @override
  Future<void> markAllRead() async {
    final response = await notificationApi.markAllRead();
    if (response.isSuccess) {
      return;
    }
    throw Exception(response.message);
  }

  @override
  Future<void> deleteNotification(String id) async {
    final response = await notificationApi.deleteNotification(id);
    if (response.isSuccess) {
      return;
    }
    throw Exception(response.message);
  }
}
