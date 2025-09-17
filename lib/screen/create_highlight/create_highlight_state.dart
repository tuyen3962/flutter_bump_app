import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum CreateMode { record, upload }

class LibraryItem {
  final String id;
  final String title;
  final String duration;
  final String thumbnail;

  const LibraryItem({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnail,
  });

  LibraryItem copyWith({
    String? id,
    String? title,
    String? duration,
    String? thumbnail,
  }) {
    return LibraryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }
}

class CreateHighlightState extends BaseState {
  final List<LibraryItem> libraryItems;
  final List<String> selectedVideoIds;
  final CreateMode activeMode;
  final bool isLoading;
  final bool showNameDialog;
  final String highlightName;

  const CreateHighlightState({
    this.libraryItems = const [],
    this.selectedVideoIds = const [],
    this.activeMode = CreateMode.record,
    this.isLoading = false,
    this.showNameDialog = false,
    this.highlightName = '',
  });

  CreateHighlightState copyWith({
    List<LibraryItem>? libraryItems,
    List<String>? selectedVideoIds,
    CreateMode? activeMode,
    bool? isLoading,
    bool? showNameDialog,
    String? highlightName,
  }) {
    return CreateHighlightState(
      libraryItems: libraryItems ?? this.libraryItems,
      selectedVideoIds: selectedVideoIds ?? this.selectedVideoIds,
      activeMode: activeMode ?? this.activeMode,
      isLoading: isLoading ?? this.isLoading,
      showNameDialog: showNameDialog ?? this.showNameDialog,
      highlightName: highlightName ?? this.highlightName,
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
        libraryItems,
        selectedVideoIds,
        activeMode,
        isLoading,
        showNameDialog,
        highlightName,
      ];
}
