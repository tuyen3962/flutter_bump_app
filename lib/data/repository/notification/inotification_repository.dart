import 'package:flutter_bump_app/data/remote/notification/notification_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class INotificationRepository extends IBaseRepository {
  Future<PaginatedResponse<AppNotification>> getNotifications(
      {int page = 1, int limit = 20});

  Future<AppNotification> getNotification(String id);

  Future<void> markRead(String id);

  Future<void> markAllRead();

  Future<void> deleteNotification(String id);
}
