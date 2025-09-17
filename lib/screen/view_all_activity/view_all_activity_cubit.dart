import 'dart:async';
import 'dart:math';

import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/screen/view_all_activity/view_all_activity_state.dart';

class ViewAllActivityCubit extends BaseCubit<ViewAllActivityState> {
  late final AccountService accountService = locator.get();
  Timer? _progressTimer;

  ViewAllActivityCubit() : super(const ViewAllActivityState());

  @override
  Future<void> close() {
    _progressTimer?.cancel();
    return super.close();
  }

  void initializeActivity() {
    emit(state.copyWith(isLoading: true));

    // Initialize with mock data - expanded version from home
    final mockActivities = [
      const ActivityItem(
        id: 1,
        title: "Basketball Championship Finals",
        status: ActivityStatus.processing,
        time: "2 min ago",
        icon: "🏀",
        progress: 87.0,
      ),
      const ActivityItem(
        id: 2,
        title: "Soccer Match Highlights",
        status: ActivityStatus.completed,
        time: "2 hours ago",
        icon: "⚽",
        duration: "3:45",
      ),
      const ActivityItem(
        id: 3,
        title: "Tennis Tournament Upload",
        status: ActivityStatus.completed,
        time: "5 hours ago",
        icon: "🎾",
        duration: "2:34",
      ),
      const ActivityItem(
        id: 4,
        title: "Workout Session Highlights",
        status: ActivityStatus.processing,
        time: "8 min ago",
        icon: "💪",
        progress: 45.0,
      ),
      const ActivityItem(
        id: 5,
        title: "Gaming Montage",
        status: ActivityStatus.failed,
        time: "1 day ago",
        icon: "🎮",
      ),
      const ActivityItem(
        id: 6,
        title: "Cooking Tutorial",
        status: ActivityStatus.queued,
        time: "3 min ago",
        icon: "👨‍🍳",
      ),
      const ActivityItem(
        id: 7,
        title: "Music Performance",
        status: ActivityStatus.completed,
        time: "1 day ago",
        icon: "🎵",
        duration: "4:20",
      ),
      const ActivityItem(
        id: 8,
        title: "Travel Vlog",
        status: ActivityStatus.uploading,
        time: "5 min ago",
        icon: "✈️",
        progress: 65.0,
      ),
      const ActivityItem(
        id: 9,
        title: "Art Timelapse",
        status: ActivityStatus.failed,
        time: "2 days ago",
        icon: "🎨",
      ),
      const ActivityItem(
        id: 10,
        title: "Dance Practice",
        status: ActivityStatus.completed,
        time: "3 days ago",
        icon: "💃",
        duration: "2:15",
      ),
    ];

    emit(state.copyWith(
      activities: mockActivities,
      isLoading: false,
    ));

    _startProgressSimulation();
  }

  void setFilter(ActivityFilter filter) {
    emit(state.copyWith(currentFilter: filter));
  }

  void _startProgressSimulation() {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final updatedActivities = state.activities.map((activity) {
        if ((activity.status == ActivityStatus.processing || activity.status == ActivityStatus.uploading) &&
            activity.progress != null &&
            activity.progress! < 100) {
          final newProgress = min(activity.progress! + Random().nextDouble() * 5, 100.0);
          return activity.copyWith(
            progress: newProgress,
            status: newProgress >= 100 ? ActivityStatus.completed : activity.status,
            duration: newProgress >= 100 ? "3:${Random().nextInt(60).toString().padLeft(2, '0')}" : null,
          );
        }
        return activity;
      }).toList();

      emit(state.copyWith(activities: updatedActivities));
    });
  }

  void retryFailedActivity(int activityId) {
    final updatedActivities = state.activities.map((activity) {
      if (activity.id == activityId && activity.status == ActivityStatus.failed) {
        return activity.copyWith(
          status: ActivityStatus.queued,
          progress: 0,
        );
      }
      return activity;
    }).toList();

    emit(state.copyWith(activities: updatedActivities));
  }

  void removeActivity(int activityId) {
    final updatedActivities = state.activities.where((activity) => activity.id != activityId).toList();
    emit(state.copyWith(activities: updatedActivities));
  }

  Future<void> refreshActivity() async {
    emit(state.copyWith(isRefreshing: true));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // In real app, fetch from API
    // final activities = await accountService.getRecentActivities();

    emit(state.copyWith(isRefreshing: false));
  }

  String getStatusText(ActivityStatus status) {
    switch (status) {
      case ActivityStatus.processing:
        return 'Processing';
      case ActivityStatus.completed:
        return 'Processing complete';
      case ActivityStatus.failed:
        return 'Failed';
      case ActivityStatus.queued:
        return 'Queued';
      case ActivityStatus.uploading:
        return 'Uploading';
    }
  }

  String getStatusIcon(ActivityStatus status) {
    switch (status) {
      case ActivityStatus.processing:
        return '🔄';
      case ActivityStatus.completed:
        return '✅';
      case ActivityStatus.failed:
        return '❌';
      case ActivityStatus.queued:
        return '⏳';
      case ActivityStatus.uploading:
        return '☁️';
    }
  }
}
