import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class CreateHighlightState extends BaseState {
  final List<String> selectedVideoIds;
  final bool isLoading;

  const CreateHighlightState(
      {this.selectedVideoIds = const [], this.isLoading = false});

  CreateHighlightState copyWith({
    List<String>? selectedVideoIds,
    bool? isLoading,
  }) {
    return CreateHighlightState(
      selectedVideoIds: selectedVideoIds ?? this.selectedVideoIds,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool isVideoSelected(String videoId) {
    return selectedVideoIds.contains(videoId);
  }

  int getSelectionNumber(String videoId) {
    final index = selectedVideoIds.indexOf(videoId);
    return index >= 0 ? index + 1 : 0;
  }

  bool get hasSelectedVideos => selectedVideoIds.isNotEmpty;

  int get selectedCount => selectedVideoIds.length;

  @override
  List<Object?> get props => [
        selectedVideoIds,
        isLoading,
      ];
}
