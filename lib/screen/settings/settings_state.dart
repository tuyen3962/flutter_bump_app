import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum VideoQuality { low, medium, high, auto }

enum NotificationType { all, important, none }

class SettingsState extends BaseState {
  // Account Settings
  final String userName;
  final String userEmail;
  final String profileImageUrl;

  // App Preferences
  final bool enableNotifications;
  final NotificationType notificationType;
  final bool enableAutoUpload;
  final VideoQuality videoQuality;
  final bool enableDarkMode;
  final String language;

  // Privacy Settings
  final bool shareAnalytics;
  final bool allowDataCollection;
  final bool enableLocationServices;

  // Storage Settings
  final double storageUsed; // in GB
  final double totalStorage; // in GB
  final bool enableCloudBackup;
  final bool enableAutoDelete;
  final int autoDeleteDays;

  // Loading States
  final bool isLoading;
  final bool isSyncing;

  const SettingsState({
    this.userName = 'Alex Johnson',
    this.userEmail = 'alex.johnson@email.com',
    this.profileImageUrl = '',
    this.enableNotifications = true,
    this.notificationType = NotificationType.all,
    this.enableAutoUpload = false,
    this.videoQuality = VideoQuality.high,
    this.enableDarkMode = false,
    this.language = 'English',
    this.shareAnalytics = true,
    this.allowDataCollection = false,
    this.enableLocationServices = true,
    this.storageUsed = 2.4,
    this.totalStorage = 16.0,
    this.enableCloudBackup = true,
    this.enableAutoDelete = false,
    this.autoDeleteDays = 30,
    this.isLoading = false,
    this.isSyncing = false,
  });

  SettingsState copyWith({
    String? userName,
    String? userEmail,
    String? profileImageUrl,
    bool? enableNotifications,
    NotificationType? notificationType,
    bool? enableAutoUpload,
    VideoQuality? videoQuality,
    bool? enableDarkMode,
    String? language,
    bool? shareAnalytics,
    bool? allowDataCollection,
    bool? enableLocationServices,
    double? storageUsed,
    double? totalStorage,
    bool? enableCloudBackup,
    bool? enableAutoDelete,
    int? autoDeleteDays,
    bool? isLoading,
    bool? isSyncing,
  }) {
    return SettingsState(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      notificationType: notificationType ?? this.notificationType,
      enableAutoUpload: enableAutoUpload ?? this.enableAutoUpload,
      videoQuality: videoQuality ?? this.videoQuality,
      enableDarkMode: enableDarkMode ?? this.enableDarkMode,
      language: language ?? this.language,
      shareAnalytics: shareAnalytics ?? this.shareAnalytics,
      allowDataCollection: allowDataCollection ?? this.allowDataCollection,
      enableLocationServices: enableLocationServices ?? this.enableLocationServices,
      storageUsed: storageUsed ?? this.storageUsed,
      totalStorage: totalStorage ?? this.totalStorage,
      enableCloudBackup: enableCloudBackup ?? this.enableCloudBackup,
      enableAutoDelete: enableAutoDelete ?? this.enableAutoDelete,
      autoDeleteDays: autoDeleteDays ?? this.autoDeleteDays,
      isLoading: isLoading ?? this.isLoading,
      isSyncing: isSyncing ?? this.isSyncing,
    );
  }

  double get storagePercentage => storageUsed / totalStorage;

  String get videoQualityText {
    switch (videoQuality) {
      case VideoQuality.low:
        return 'Low (720p)';
      case VideoQuality.medium:
        return 'Medium (1080p)';
      case VideoQuality.high:
        return 'High (4K)';
      case VideoQuality.auto:
        return 'Auto';
    }
  }

  String get notificationTypeText {
    switch (notificationType) {
      case NotificationType.all:
        return 'All notifications';
      case NotificationType.important:
        return 'Important only';
      case NotificationType.none:
        return 'None';
    }
  }

  List<String> get availableLanguages => [
        'English',
        'Vietnamese',
        'Spanish',
        'French',
        'German',
        'Japanese',
        'Korean',
        'Chinese',
      ];

  @override
  List<Object?> get props => [
        userName,
        userEmail,
        profileImageUrl,
        enableNotifications,
        notificationType,
        enableAutoUpload,
        videoQuality,
        enableDarkMode,
        language,
        shareAnalytics,
        allowDataCollection,
        enableLocationServices,
        storageUsed,
        totalStorage,
        enableCloudBackup,
        enableAutoDelete,
        autoDeleteDays,
        isLoading,
        isSyncing,
      ];
}
