import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum HighlightFilter {
  all,
  posted,
  notPosted,
}

class MyHighlightState extends BaseState {
  final int totalHighlights;
  final int totalViews;
  final int totalLikes;
  final HighlightFilter? currentFilter;

  const MyHighlightState({
    super.isLoading = false,
    this.totalHighlights = 0,
    this.totalViews = 0,
    this.totalLikes = 0,
    this.currentFilter = HighlightFilter.all,
  });

  MyHighlightState copyWith({
    bool? isLoading,
    int? totalHighlights,
    int? totalViews,
    int? totalLikes,
    HighlightFilter? currentFilter,
  }) {
    return MyHighlightState(
      isLoading: isLoading ?? this.isLoading,
      totalHighlights: totalHighlights ?? this.totalHighlights,
      totalViews: totalViews ?? this.totalViews,
      totalLikes: totalLikes ?? this.totalLikes,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        totalHighlights,
        totalViews,
        totalLikes,
        currentFilter,
      ];
}
