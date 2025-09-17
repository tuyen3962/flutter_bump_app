import 'dart:async';
import 'dart:math';

import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'activity_state.dart';

class ActivityCubit extends BaseCubit<ActivityState> {
  late final AccountService accountService = locator.get();
  Timer? _progressTimer;

  ActivityCubit() : super(const ActivityState());

  @override
  Future<void> close() {
    _progressTimer?.cancel();
    return super.close();
  }

  void initializeActivity() {
    emit(state.copyWith(isLoading: true));

    // Initialize with mock data
    final mockVideos = [
      const VideoItem(
        id: 1,
        title: "Basketball Championship Finals",
        progress: 87,
        status: VideoStatus.processing,
        timeAgo: "2 min ago",
        thumbnail: "thumb1",
      ),
      const VideoItem(
        id: 2,
        title: "Soccer Match Highlights",
        progress: 100,
        status: VideoStatus.completed,
        timeAgo: "2 hours ago",
        duration: "3:45",
        thumbnail: "thumb2",
      ),
      const VideoItem(
        id: 3,
        title: "Tennis Tournament Upload",
        progress: 100,
        status: VideoStatus.completed,
        timeAgo: "5 hours ago",
        duration: "2:34",
        thumbnail: "thumb3",
      ),
      const VideoItem(
        id: 4,
        title: "Workout Session Highlights",
        progress: 45,
        status: VideoStatus.processing,
        timeAgo: "8 min ago",
        thumbnail: "thumb4",
      ),
      const VideoItem(
        id: 5,
        title: "Gaming Montage",
        progress: 0,
        status: VideoStatus.failed,
        timeAgo: "1 day ago",
        thumbnail: "thumb5",
      ),
      const VideoItem(
        id: 6,
        title: "Cooking Tutorial",
        progress: 0,
        status: VideoStatus.queued,
        timeAgo: "3 min ago",
        thumbnail: "thumb6",
      ),
    ];

    emit(state.copyWith(
      videos: mockVideos,
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
      final updatedVideos = state.videos.map((video) {
        if (video.status == VideoStatus.processing && video.progress < 100) {
          final newProgress = min(video.progress + Random().nextDouble() * 5, 100.0);
          return video.copyWith(
            progress: newProgress,
            status: newProgress >= 100 ? VideoStatus.completed : VideoStatus.processing,
          );
        }
        return video;
      }).toList();

      emit(state.copyWith(videos: updatedVideos));
    });
  }

  void retryFailedVideo(int videoId) {
    final updatedVideos = state.videos.map((video) {
      if (video.id == videoId && video.status == VideoStatus.failed) {
        return video.copyWith(
          status: VideoStatus.queued,
          progress: 0,
        );
      }
      return video;
    }).toList();

    emit(state.copyWith(videos: updatedVideos));
  }

  void removeVideo(int videoId) {
    final updatedVideos = state.videos.where((video) => video.id != videoId).toList();
    emit(state.copyWith(videos: updatedVideos));
  }

  Future<void> refreshActivity() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isLoading: false));
  }
}
