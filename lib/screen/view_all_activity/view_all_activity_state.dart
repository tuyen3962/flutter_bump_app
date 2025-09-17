import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum ActivityStatus { processing, completed, failed, queued, uploading }

enum ActivityFilter { all, processing, completed, failed }

class ActivityItem {
  final int id;
  final String title;
  final ActivityStatus status;
  final String time;
  final String? icon;
  final double? progress;
  final String? duration;

  const ActivityItem({
    required this.id,
    required this.title,
    required this.status,
    required this.time,
    this.icon,
    this.progress,
    this.duration,
  });

  ActivityItem copyWith({
    int? id,
    String? title,
    ActivityStatus? status,
    String? time,
    String? icon,
    double? progress,
    String? duration,
  }) {
    return ActivityItem(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      time: time ?? this.time,
      icon: icon ?? this.icon,
      progress: progress ?? this.progress,
      duration: duration ?? this.duration,
    );
  }
}

class ViewAllActivityState extends BaseState {
  final List<ActivityItem> activities;
  final ActivityFilter currentFilter;
  final bool isLoading;
  final bool isRefreshing;

  const ViewAllActivityState({
    this.activities = const [],
    this.currentFilter = ActivityFilter.all,
    this.isLoading = false,
    this.isRefreshing = false,
  });

  ViewAllActivityState copyWith({
    List<ActivityItem>? activities,
    ActivityFilter? currentFilter,
    bool? isLoading,
    bool? isRefreshing,
  }) {
    return ViewAllActivityState(
      activities: activities ?? this.activities,
      currentFilter: currentFilter ?? this.currentFilter,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  List<ActivityItem> get filteredActivities {
    switch (currentFilter) {
      case ActivityFilter.processing:
        return activities
            .where((activity) =>
                activity.status == ActivityStatus.processing ||
                activity.status == ActivityStatus.queued ||
                activity.status == ActivityStatus.uploading)
            .toList();
      case ActivityFilter.completed:
        return activities.where((activity) => activity.status == ActivityStatus.completed).toList();
      case ActivityFilter.failed:
        return activities.where((activity) => activity.status == ActivityStatus.failed).toList();
      case ActivityFilter.all:
      return activities;
    }
  }

  int get processingCount => activities
      .where((a) =>
          a.status == ActivityStatus.processing ||
          a.status == ActivityStatus.queued ||
          a.status == ActivityStatus.uploading)
      .length;

  int get completedCount => activities.where((a) => a.status == ActivityStatus.completed).length;

  int get failedCount => activities.where((a) => a.status == ActivityStatus.failed).length;

  int get totalCount => activities.length;

  @override
  List<Object?> get props => [
        activities,
        currentFilter,
        isLoading,
        isRefreshing,
      ];
}
