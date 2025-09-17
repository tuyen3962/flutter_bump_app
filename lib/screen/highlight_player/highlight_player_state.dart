import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class RecentHighlight {
  final int id;
  final String title;
  final String views;
  final String thumbnail;

  const RecentHighlight({
    required this.id,
    required this.title,
    required this.views,
    required this.thumbnail,
  });
}

class HighlightPlayerState extends BaseState {
  final String videoTitle;
  final String videoDescription;
  final int viewCount;
  final int likeCount;
  final bool isPlaying;
  final double currentPosition; // 0.0 to 1.0
  final String currentTime;
  final String totalDuration;
  final Map<String, bool> sharedPlatforms;
  final List<RecentHighlight> recentHighlights;
  final bool isLoading;

  const HighlightPlayerState({
    this.videoTitle = 'Gaming Montage #1',
    this.videoDescription = 'Created from 2 videos • 3:42 duration',
    this.viewCount = 1234,
    this.likeCount = 89,
    this.isPlaying = false,
    this.currentPosition = 0.33, // 1:24 / 3:42
    this.currentTime = '1:24',
    this.totalDuration = '3:42',
    this.sharedPlatforms = const {
      'youtube': false,
      'tiktok': true,
    },
    this.recentHighlights = const [],
    this.isLoading = false,
  });

  HighlightPlayerState copyWith({
    String? videoTitle,
    String? videoDescription,
    int? viewCount,
    int? likeCount,
    bool? isPlaying,
    double? currentPosition,
    String? currentTime,
    String? totalDuration,
    Map<String, bool>? sharedPlatforms,
    List<RecentHighlight>? recentHighlights,
    bool? isLoading,
  }) {
    return HighlightPlayerState(
      videoTitle: videoTitle ?? this.videoTitle,
      videoDescription: videoDescription ?? this.videoDescription,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
      currentTime: currentTime ?? this.currentTime,
      totalDuration: totalDuration ?? this.totalDuration,
      sharedPlatforms: sharedPlatforms ?? this.sharedPlatforms,
      recentHighlights: recentHighlights ?? this.recentHighlights,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool isPlatformShared(String platform) {
    return sharedPlatforms[platform] ?? false;
  }

  @override
  List<Object?> get props => [
        videoTitle,
        videoDescription,
        viewCount,
        likeCount,
        isPlaying,
        currentPosition,
        currentTime,
        totalDuration,
        sharedPlatforms,
        recentHighlights,
        isLoading,
      ];
}