import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum VideoStatus { processing, completed, failed, queued, uploading }

enum ActivityFilter { all, processing, completed, failed }

class VideoItem {
  final int id;
  final String title;
  final double progress;
  final VideoStatus status;
  final String timeAgo;
  final String? duration;
  final String thumbnail;

  const VideoItem({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
    required this.timeAgo,
    this.duration,
    required this.thumbnail,
  });

  VideoItem copyWith({
    int? id,
    String? title,
    double? progress,
    VideoStatus? status,
    String? timeAgo,
    String? duration,
    String? thumbnail,
  }) {
    return VideoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      timeAgo: timeAgo ?? this.timeAgo,
      duration: duration ?? this.duration,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}

class ActivityState extends BaseState {
  final List<VideoItem> videos;
  final ActivityFilter currentFilter;
  final bool isLoading;

  const ActivityState({
    this.videos = const [],
    this.currentFilter = ActivityFilter.all,
    this.isLoading = false,
  });

  ActivityState copyWith({
    List<VideoItem>? videos,
    ActivityFilter? currentFilter,
    bool? isLoading,
  }) {
    return ActivityState(
      videos: videos ?? this.videos,
      currentFilter: currentFilter ?? this.currentFilter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  List<VideoItem> get filteredVideos {
    switch (currentFilter) {
      case ActivityFilter.processing:
        return videos
            .where((video) =>
                video.status == VideoStatus.processing ||
                video.status == VideoStatus.queued ||
                video.status == VideoStatus.uploading)
            .toList();
      case ActivityFilter.completed:
        return videos.where((video) => video.status == VideoStatus.completed).toList();
      case ActivityFilter.failed:
        return videos.where((video) => video.status == VideoStatus.failed).toList();
      case ActivityFilter.all:
        return videos;
    }
  }

  int get processingCount => videos
      .where((v) =>
          v.status == VideoStatus.processing || v.status == VideoStatus.queued || v.status == VideoStatus.uploading)
      .length;

  int get completedCount => videos.where((v) => v.status == VideoStatus.completed).length;

  int get totalCount => videos.length;

  @override
  List<Object?> get props => [
        videos,
        currentFilter,
        isLoading,
      ];
}
