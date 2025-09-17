import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_state.dart';

class CreateHighlightCubit extends BaseCubit<CreateHighlightState> {
  late final AccountService accountService = locator.get();

  CreateHighlightCubit() : super(const CreateHighlightState());

  void initializeLibrary() {
    emit(state.copyWith(isLoading: true));

    // Initialize with mock data
    final mockLibraryItems = [
      const LibraryItem(
        id: '1',
        title: 'Match Highlights 2024',
        duration: '2:45',
        thumbnail: '#F3F4F6',
      ),
      const LibraryItem(
        id: '2',
        title: 'Training Session',
        duration: '1:30',
        thumbnail: '#E5E7EB',
      ),
      const LibraryItem(
        id: '3',
        title: 'Tournament Finals',
        duration: '3:20',
        thumbnail: '#F3F4F6',
      ),
      const LibraryItem(
        id: '4',
        title: 'Practice Drills',
        duration: '0:45',
        thumbnail: '#E5E7EB',
      ),
      const LibraryItem(
        id: '5',
        title: 'Doubles Match',
        duration: '4:15',
        thumbnail: '#F3F4F6',
      ),
      const LibraryItem(
        id: '6',
        title: 'Serve Practice',
        duration: '1:10',
        thumbnail: '#E5E7EB',
      ),
    ];

    emit(state.copyWith(
      libraryItems: mockLibraryItems,
      isLoading: false,
    ));
  }

  void setActiveMode(CreateMode mode) {
    emit(state.copyWith(activeMode: mode));
  }

  void toggleVideoSelection(String videoId) {
    final currentSelection = List<String>.from(state.selectedVideoIds);

    if (currentSelection.contains(videoId)) {
      currentSelection.remove(videoId);
    } else {
      currentSelection.add(videoId);
    }

    emit(state.copyWith(selectedVideoIds: currentSelection));
  }

  void clearSelection() {
    emit(state.copyWith(selectedVideoIds: []));
  }

  void showNameDialog() {
    emit(state.copyWith(showNameDialog: true));
  }

  void hideNameDialog() {
    emit(state.copyWith(
      showNameDialog: false,
      highlightName: '',
    ));
  }

  void updateHighlightName(String name) {
    emit(state.copyWith(highlightName: name));
  }

  Future<bool> createHighlight() async {
    if (state.highlightName.trim().isEmpty) {
      return false;
    }

    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call to create highlight
      await Future.delayed(const Duration(seconds: 2));

      // In real app, call API
      // final result = await accountService.createHighlight(
      //   name: state.highlightName,
      //   videoIds: state.selectedVideoIds,
      // );

      emit(state.copyWith(
        isLoading: false,
        showNameDialog: false,
        highlightName: '',
        selectedVideoIds: [],
      ));

      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      return false;
    }
  }

  Future<void> recordVideo() async {
    // Handle video recording
    // This would typically open camera/recording interface
    emit(state.copyWith(isLoading: true));

    // Simulate recording process
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isLoading: false));
  }

  Future<void> uploadVideo() async {
    // Handle video upload
    // This would typically open file picker
    emit(state.copyWith(isLoading: true));

    // Simulate upload process
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isLoading: false));
  }

  Future<void> refreshLibrary() async {
    emit(state.copyWith(isLoading: true));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // In real app, fetch from API
    // final items = await accountService.getUserVideoLibrary();

    emit(state.copyWith(isLoading: false));
  }
}
