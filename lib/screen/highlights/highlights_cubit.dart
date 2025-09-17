import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'highlights_state.dart';

class HighlightsCubit extends BaseCubit<HighlightsState> {
  late final AccountService accountService = locator.get();

  HighlightsCubit() : super(const HighlightsState());

  void initializeHighlights() {
    emit(state.copyWith(isLoading: true));

    // Initialize with mock data
    final mockHighlights = [
      const Highlight(
        id: '1',
        title: 'Amazing Rally Shot',
        duration: '0:15',
        thumbnail: '#E5E7EB',
        views: 1240,
        likes: 89,
        socialPostStatus: SocialPostStatus.posted,
        createdAt: '2 days ago',
        platforms: ['YouTube', 'TikTok'],
      ),
      const Highlight(
        id: '2',
        title: 'Perfect Serve Ace',
        duration: '0:08',
        thumbnail: '#E5E7EB',
        views: 854,
        likes: 23,
        socialPostStatus: SocialPostStatus.posted,
        createdAt: '5 days ago',
        platforms: ['Instagram'],
      ),
      const Highlight(
        id: '3',
        title: 'Diving Save',
        duration: '0:12',
        thumbnail: '#E5E7EB',
        views: 0,
        likes: 0,
        socialPostStatus: SocialPostStatus.notPosted,
        createdAt: '1 week ago',
      ),
      const Highlight(
        id: '4',
        title: 'Championship Point',
        duration: '0:20',
        thumbnail: '#E5E7EB',
        views: 3420,
        likes: 234,
        socialPostStatus: SocialPostStatus.posted,
        createdAt: '2 weeks ago',
        platforms: ['YouTube', 'TikTok'],
      ),
    ];

    emit(state.copyWith(
      highlights: mockHighlights,
      isLoading: false,
    ));
  }

  void setFilter(HighlightFilter filter) {
    emit(state.copyWith(currentFilter: filter));
  }

  void deleteHighlight(String highlightId) {
    final updatedHighlights = state.highlights.where((highlight) => highlight.id != highlightId).toList();

    emit(state.copyWith(highlights: updatedHighlights));
  }

  void postToSocial(String highlightId, List<String> platforms) {
    final updatedHighlights = state.highlights.map((highlight) {
      if (highlight.id == highlightId) {
        return highlight.copyWith(
          socialPostStatus: SocialPostStatus.posted,
          platforms: platforms,
        );
      }
      return highlight;
    }).toList();

    emit(state.copyWith(highlights: updatedHighlights));
  }

  Future<void> refreshHighlights() async {
    emit(state.copyWith(isLoading: true));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // In real app, fetch from API
    // final highlights = await accountService.getUserHighlights();

    emit(state.copyWith(isLoading: false));
  }

  void likeHighlight(String highlightId) {
    final updatedHighlights = state.highlights.map((highlight) {
      if (highlight.id == highlightId) {
        return highlight.copyWith(likes: highlight.likes + 1);
      }
      return highlight;
    }).toList();

    emit(state.copyWith(highlights: updatedHighlights));
  }
}
