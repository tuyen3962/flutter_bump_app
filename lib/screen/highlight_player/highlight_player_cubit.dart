import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/screen/highlight_player/highlight_player_state.dart';

class HighlightPlayerCubit extends BaseCubit<HighlightPlayerState> {
  late final AccountService accountService = locator.get();

  HighlightPlayerCubit() : super(const HighlightPlayerState());

  void initializePlayer() {
    emit(state.copyWith(isLoading: true));

    // Mock recent highlights
    final mockRecentHighlights = [
      const RecentHighlight(
        id: 1,
        title: "Gaming Montage #2",
        views: "1.2K",
        thumbnail: "thumb1",
      ),
      const RecentHighlight(
        id: 2,
        title: "Travel Adventure",
        views: "856",
        thumbnail: "thumb2",
      ),
      const RecentHighlight(
        id: 3,
        title: "Cooking Tips",
        views: "2.1K",
        thumbnail: "thumb3",
      ),
    ];

    emit(state.copyWith(
      recentHighlights: mockRecentHighlights,
      isLoading: false,
    ));
  }

  void togglePlayPause() {
    emit(state.copyWith(isPlaying: !state.isPlaying));
  }

  void updatePosition(double position) {
    // Convert position to time format
    final totalSeconds = _parseTimeToSeconds(state.totalDuration);
    final currentSeconds = (totalSeconds * position).round();
    final currentTime = _formatSecondsToTime(currentSeconds);

    emit(state.copyWith(
      currentPosition: position,
      currentTime: currentTime,
    ));
  }

  void togglePlatformShare(String platform) {
    final updatedPlatforms = Map<String, bool>.from(state.sharedPlatforms);
    updatedPlatforms[platform] = !updatedPlatforms[platform]!;

    emit(state.copyWith(sharedPlatforms: updatedPlatforms));
  }

  Future<void> shareToYouTube() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call to share to YouTube
      await Future.delayed(const Duration(seconds: 2));

      final updatedPlatforms = Map<String, bool>.from(state.sharedPlatforms);
      updatedPlatforms['youtube'] = true;

      emit(state.copyWith(
        sharedPlatforms: updatedPlatforms,
        isLoading: false,
      ));

      // Success handled in UI
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // Error handled in UI
    }
  }

  Future<void> shareToTikTok() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call to share to TikTok
      await Future.delayed(const Duration(seconds: 2));

      final updatedPlatforms = Map<String, bool>.from(state.sharedPlatforms);
      updatedPlatforms['tiktok'] = true;

      emit(state.copyWith(
        sharedPlatforms: updatedPlatforms,
        isLoading: false,
      ));

      // Success handled in UI
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // Error handled in UI
    }
  }

  Future<void> downloadVideo() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate download process
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(isLoading: false));

      // Success handled in UI
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      // Error handled in UI
    }
  }

  void likeVideo() {
    emit(state.copyWith(likeCount: state.likeCount + 1));
  }

  void playRecentHighlight(int highlightId) {
    // Handle playing another highlight
    // This would typically load new video data
    final highlight = state.recentHighlights.firstWhere(
      (h) => h.id == highlightId,
      orElse: () => const RecentHighlight(
        id: 0,
        title: 'Unknown',
        views: '0',
        thumbnail: '',
      ),
    );

    if (highlight.id != 0) {
      emit(state.copyWith(
        videoTitle: highlight.title,
        videoDescription: 'Recent highlight • Duration varies',
        viewCount: _parseViews(highlight.views),
        likeCount: 0,
        currentPosition: 0.0,
        currentTime: '0:00',
        isPlaying: false,
      ));
    }
  }

  int _parseTimeToSeconds(String time) {
    final parts = time.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  String _formatSecondsToTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  int _parseViews(String views) {
    if (views.endsWith('K')) {
      return (double.parse(views.replaceAll('K', '')) * 1000).round();
    }
    return int.tryParse(views) ?? 0;
  }
}
