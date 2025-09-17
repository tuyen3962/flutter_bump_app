import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum SocialPostStatus { posted, notPosted }

enum HighlightFilter { all, posted, notPosted }

class Highlight {
  final String id;
  final String title;
  final String duration;
  final String thumbnail;
  final int views;
  final int likes;
  final SocialPostStatus socialPostStatus;
  final String createdAt;
  final List<String>? platforms;

  const Highlight({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnail,
    required this.views,
    required this.likes,
    required this.socialPostStatus,
    required this.createdAt,
    this.platforms,
  });

  Highlight copyWith({
    String? id,
    String? title,
    String? duration,
    String? thumbnail,
    int? views,
    int? likes,
    SocialPostStatus? socialPostStatus,
    String? createdAt,
    List<String>? platforms,
  }) {
    return Highlight(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      thumbnail: thumbnail ?? this.thumbnail,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      socialPostStatus: socialPostStatus ?? this.socialPostStatus,
      createdAt: createdAt ?? this.createdAt,
      platforms: platforms ?? this.platforms,
    );
  }
}

class HighlightsState extends BaseState {
  final List<Highlight> highlights;
  final HighlightFilter currentFilter;
  final bool isLoading;

  const HighlightsState({
    this.highlights = const [],
    this.currentFilter = HighlightFilter.all,
    this.isLoading = false,
  });

  HighlightsState copyWith({
    List<Highlight>? highlights,
    HighlightFilter? currentFilter,
    bool? isLoading,
  }) {
    return HighlightsState(
      highlights: highlights ?? this.highlights,
      currentFilter: currentFilter ?? this.currentFilter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  List<Highlight> get filteredHighlights {
    switch (currentFilter) {
      case HighlightFilter.posted:
        return highlights.where((h) => h.socialPostStatus == SocialPostStatus.posted).toList();
      case HighlightFilter.notPosted:
        return highlights.where((h) => h.socialPostStatus == SocialPostStatus.notPosted).toList();
      case HighlightFilter.all:
        return highlights;
    }
  }

  int get totalHighlights => highlights.length;

  int get totalViews => highlights.fold(0, (sum, h) => sum + h.views);

  int get totalLikes => highlights.fold(0, (sum, h) => sum + h.likes);

  @override
  List<Object?> get props => [
        highlights,
        currentFilter,
        isLoading,
      ];
}
