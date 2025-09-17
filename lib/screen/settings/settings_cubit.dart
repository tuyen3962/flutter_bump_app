import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'settings_state.dart';

class SettingsCubit extends BaseCubit<SettingsState> {
  late final AccountService accountService = locator.get();

  SettingsCubit() : super(const SettingsState());

  void initializeSettings() {
    emit(state.copyWith(isLoading: true));

    // Simulate loading settings from storage/API
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(state.copyWith(isLoading: false));
    });
  }

  // Account Settings
  void updateUserName(String name) {
    emit(state.copyWith(userName: name));
    _syncSettings();
  }

  void updateUserEmail(String email) {
    emit(state.copyWith(userEmail: email));
    _syncSettings();
  }

  void updateProfileImage(String imageUrl) {
    emit(state.copyWith(profileImageUrl: imageUrl));
    _syncSettings();
  }

  // App Preferences
  void toggleNotifications(bool enabled) {
    emit(state.copyWith(enableNotifications: enabled));
    _syncSettings();
  }

  void updateNotificationType(NotificationType type) {
    emit(state.copyWith(notificationType: type));
    _syncSettings();
  }

  void toggleAutoUpload(bool enabled) {
    emit(state.copyWith(enableAutoUpload: enabled));
    _syncSettings();
  }

  void updateVideoQuality(VideoQuality quality) {
    emit(state.copyWith(videoQuality: quality));
    _syncSettings();
  }

  void toggleDarkMode(bool enabled) {
    emit(state.copyWith(enableDarkMode: enabled));
    _syncSettings();
  }

  void updateLanguage(String language) {
    emit(state.copyWith(language: language));
    _syncSettings();
  }

  // Privacy Settings
  void toggleShareAnalytics(bool enabled) {
    emit(state.copyWith(shareAnalytics: enabled));
    _syncSettings();
  }

  void toggleDataCollection(bool enabled) {
    emit(state.copyWith(allowDataCollection: enabled));
    _syncSettings();
  }

  void toggleLocationServices(bool enabled) {
    emit(state.copyWith(enableLocationServices: enabled));
    _syncSettings();
  }

  // Storage Settings
  void toggleCloudBackup(bool enabled) {
    emit(state.copyWith(enableCloudBackup: enabled));
    _syncSettings();
  }

  void toggleAutoDelete(bool enabled) {
    emit(state.copyWith(enableAutoDelete: enabled));
    _syncSettings();
  }

  void updateAutoDeleteDays(int days) {
    emit(state.copyWith(autoDeleteDays: days));
    _syncSettings();
  }

  Future<void> clearCache() async {
    emit(state.copyWith(isSyncing: true));

    try {
      // Simulate cache clearing
      await Future.delayed(const Duration(seconds: 2));

      // Update storage used (simulate cache cleared)
      final newStorageUsed = (state.storageUsed * 0.7); // Clear ~30% of storage
      emit(state.copyWith(
        storageUsed: newStorageUsed,
        isSyncing: false,
      ));
    } catch (e) {
      emit(state.copyWith(isSyncing: false));
    }
  }

  Future<void> exportData() async {
    emit(state.copyWith(isSyncing: true));

    try {
      // Simulate data export
      await Future.delayed(const Duration(seconds: 3));

      emit(state.copyWith(isSyncing: false));
    } catch (e) {
      emit(state.copyWith(isSyncing: false));
    }
  }

  Future<void> deleteAccount() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate account deletion
      await Future.delayed(const Duration(seconds: 2));

      // In real app, this would sign out user and clear all data
      // await accountService.deleteAccount();

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate sign out
      await Future.delayed(const Duration(seconds: 1));

      // In real app, clear tokens and navigate to onboarding
      // await accountService.signOut();

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> resetSettings() async {
    emit(state.copyWith(isSyncing: true));

    try {
      // Reset to default settings
      await Future.delayed(const Duration(seconds: 1));

      emit(const SettingsState().copyWith(
        userName: state.userName,
        userEmail: state.userEmail,
        profileImageUrl: state.profileImageUrl,
        isSyncing: false,
      ));
    } catch (e) {
      emit(state.copyWith(isSyncing: false));
    }
  }

  void _syncSettings() {
    // Simulate syncing settings to server
    emit(state.copyWith(isSyncing: true));

    Future.delayed(const Duration(milliseconds: 500), () {
      emit(state.copyWith(isSyncing: false));
    });
  }

  String formatStorage(double gb) {
    if (gb < 1.0) {
      return '${(gb * 1024).round()} MB';
    }
    return '${gb.toStringAsFixed(1)} GB';
  }

  List<VideoQuality> get availableVideoQualities => [
        VideoQuality.auto,
        VideoQuality.high,
        VideoQuality.medium,
        VideoQuality.low,
      ];

  List<NotificationType> get availableNotificationTypes => [
        NotificationType.all,
        NotificationType.important,
        NotificationType.none,
      ];

  List<int> get availableAutoDeleteDays => [7, 14, 30, 60, 90];
}
