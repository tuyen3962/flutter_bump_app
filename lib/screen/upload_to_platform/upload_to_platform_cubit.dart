import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'upload_to_platform_state.dart';

class UploadToPlatformCubit extends BaseCubit<UploadToPlatformState> {
  late final AccountService accountService = locator.get();

  UploadToPlatformCubit() : super(const UploadToPlatformState());

  void initializePlatform(Platform platform) {
    emit(state.copyWith(platform: platform));
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }

  void updateVisibility(Visibilitys visibility) {
    emit(state.copyWith(visibility: visibility));
  }

  void updateCategory(String category) {
    emit(state.copyWith(category: category));
  }

  void updateTags(String tags) {
    emit(state.copyWith(tags: tags));
  }

  String? validateForm() {
    if (state.title.trim().isEmpty) {
      return 'Title is required';
    }

    if (state.platform == Platform.youtube && state.category.trim().isEmpty) {
      return 'Category is required for YouTube';
    }

    if (state.title.length > state.titleMaxLength) {
      return 'Title exceeds maximum length';
    }

    if (state.description.length > state.descriptionMaxLength) {
      return 'Description exceeds maximum length';
    }

    return null; // No errors
  }

  Future<bool> publishVideo() async {
    final validationError = validateForm();
    if (validationError != null) {
      return false;
    }

    emit(state.copyWith(isUploading: true, uploadProgress: 0.0));

    try {
      // Simulate upload progress
      for (int i = 1; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 300));
        emit(state.copyWith(uploadProgress: i / 10));
      }

      // Simulate API call to upload video
      await Future.delayed(const Duration(seconds: 1));

      // In real app, call platform API
      // final result = await accountService.uploadToPlatform(
      //   platform: state.platform,
      //   title: state.title,
      //   description: state.description,
      //   visibility: state.visibility,
      //   category: state.category,
      //   tags: state.tags,
      // );

      emit(state.copyWith(
        isUploading: false,
        uploadProgress: 1.0,
      ));

      return true;
    } catch (e) {
      emit(state.copyWith(
        isUploading: false,
        uploadProgress: 0.0,
      ));
      return false;
    }
  }

  void resetForm() {
    emit(const UploadToPlatformState());
  }

  List<String> get availableCategories => [
        'Sports',
        'Entertainment',
        'Gaming',
        'Music',
        'Education',
        'Travel',
        'Comedy',
        'Technology',
      ];

  List<Visibilitys> get availableVisibilities => [
        Visibilitys.public,
        Visibilitys.unlisted,
        Visibilitys.private,
      ];
}
