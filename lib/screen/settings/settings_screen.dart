import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/settings/settings_cubit.dart';

import 'settings_state.dart';

@RoutePage()
class SettingsPage extends BaseBlocProvider<SettingsState, SettingsCubit> {
  const SettingsPage({super.key});

  @override
  Widget buildPage() {
    return const SettingsScreen();
  }

  @override
  SettingsCubit createCubit() {
    return SettingsCubit();
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends BaseBlocNoAppBarPageState<SettingsScreen, SettingsState, SettingsCubit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeSettings();
    });
  }

  @override
  String get title => 'Settings';

  @override
  Widget buildBody(BuildContext context, SettingsCubit cubit) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            backgroundColor: appTheme.gray50,
            body: Center(
              child: CircularProgressIndicator(
                color: appTheme.blue500,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: appTheme.gray50,
          body: Column(
            children: [
              // Header
              _buildHeader(state),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Account Section
                      _buildAccountSection(state),

                      SizedBox(height: 16.h),

                      // App Preferences
                      _buildAppPreferencesSection(state),

                      SizedBox(height: 16.h),

                      // Privacy Settings
                      _buildPrivacySection(state),

                      SizedBox(height: 16.h),

                      // Storage Settings
                      _buildStorageSection(state),

                      SizedBox(height: 16.h),

                      // Support & Info
                      _buildSupportSection(state),

                      SizedBox(height: 16.h),

                      // Danger Zone
                      _buildDangerZone(state),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(SettingsState state) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.back(),
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: appTheme.transparentColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: appTheme.gray600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Settings',
                style: AppStyle.bold18(),
                textAlign: TextAlign.center,
              ),
            ),
            if (state.isSyncing)
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(appTheme.blue500),
                ),
              )
            else
              SizedBox(width: 32.w), // Spacer
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSection(SettingsState state) {
    return _buildSection(
      title: 'Account',
      children: [
        // Profile Info
        ListTile(
          leading: Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: appTheme.blue100,
              borderRadius: BorderRadius.circular(24),
            ),
            child: state.profileImageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      state.profileImageUrl,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      state.userName.isNotEmpty ? state.userName[0].toUpperCase() : 'A',
                      style: AppStyle.bold18(color: appTheme.blue600),
                    ),
                  ),
          ),
          title: Text(
            state.userName,
            style: AppStyle.medium16(),
          ),
          subtitle: Text(
            state.userEmail,
            style: AppStyle.regular14(color: appTheme.gray500),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: appTheme.gray400,
          ),
          onTap: () => context.router.pushNamed('/profile'),
        ),
      ],
    );
  }

  Widget _buildAppPreferencesSection(SettingsState state) {
    return _buildSection(
      title: 'App Preferences',
      children: [
        _buildSwitchTile(
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          subtitle: state.enableNotifications ? state.notificationTypeText : 'Disabled',
          value: state.enableNotifications,
          onChanged: cubit.toggleNotifications,
        ),
        if (state.enableNotifications)
          _buildSelectTile(
            icon: Icons.tune,
            title: 'Notification Type',
            subtitle: state.notificationTypeText,
            onTap: () => _showNotificationTypeDialog(state),
          ),
        _buildSwitchTile(
          icon: Icons.cloud_upload_outlined,
          title: 'Auto Upload',
          subtitle: 'Automatically upload completed highlights',
          value: state.enableAutoUpload,
          onChanged: cubit.toggleAutoUpload,
        ),
        _buildSelectTile(
          icon: Icons.high_quality_outlined,
          title: 'Video Quality',
          subtitle: state.videoQualityText,
          onTap: () => _showVideoQualityDialog(state),
        ),
        _buildSwitchTile(
          icon: Icons.dark_mode_outlined,
          title: 'Dark Mode',
          subtitle: 'Use dark theme',
          value: state.enableDarkMode,
          onChanged: cubit.toggleDarkMode,
        ),
        _buildSelectTile(
          icon: Icons.language_outlined,
          title: 'Language',
          subtitle: state.language,
          onTap: () => _showLanguageDialog(state),
        ),
      ],
    );
  }

  Widget _buildPrivacySection(SettingsState state) {
    return _buildSection(
      title: 'Privacy & Data',
      children: [
        _buildSwitchTile(
          icon: Icons.analytics_outlined,
          title: 'Share Analytics',
          subtitle: 'Help improve the app with usage data',
          value: state.shareAnalytics,
          onChanged: cubit.toggleShareAnalytics,
        ),
        _buildSwitchTile(
          icon: Icons.data_usage_outlined,
          title: 'Data Collection',
          subtitle: 'Allow personalized recommendations',
          value: state.allowDataCollection,
          onChanged: cubit.toggleDataCollection,
        ),
        _buildSwitchTile(
          icon: Icons.location_on_outlined,
          title: 'Location Services',
          subtitle: 'Add location data to highlights',
          value: state.enableLocationServices,
          onChanged: cubit.toggleLocationServices,
        ),
      ],
    );
  }

  Widget _buildStorageSection(SettingsState state) {
    return _buildSection(
      title: 'Storage & Backup',
      children: [
        // Storage Usage
        ListTile(
          leading: Icon(
            Icons.storage_outlined,
            color: appTheme.gray600,
          ),
          title: Text(
            'Storage Usage',
            style: AppStyle.medium16(),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Text(
                '${cubit.formatStorage(state.storageUsed)} of ${cubit.formatStorage(state.totalStorage)} used',
                style: AppStyle.regular14(color: appTheme.gray500),
              ),
              SizedBox(height: 8.h),
              LinearProgressIndicator(
                value: state.storagePercentage,
                backgroundColor: appTheme.gray200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  state.storagePercentage > 0.8 ? appTheme.red500 : appTheme.blue500,
                ),
              ),
            ],
          ),
        ),

        _buildActionTile(
          icon: Icons.cleaning_services_outlined,
          title: 'Clear Cache',
          subtitle: 'Free up storage space',
          onTap: () => _showClearCacheDialog(),
        ),

        _buildSwitchTile(
          icon: Icons.cloud_outlined,
          title: 'Cloud Backup',
          subtitle: 'Backup highlights to cloud storage',
          value: state.enableCloudBackup,
          onChanged: cubit.toggleCloudBackup,
        ),

        _buildSwitchTile(
          icon: Icons.auto_delete_outlined,
          title: 'Auto Delete',
          subtitle: state.enableAutoDelete ? 'Delete old videos after ${state.autoDeleteDays} days' : 'Keep all videos',
          value: state.enableAutoDelete,
          onChanged: cubit.toggleAutoDelete,
        ),

        if (state.enableAutoDelete)
          _buildSelectTile(
            icon: Icons.schedule_outlined,
            title: 'Auto Delete Period',
            subtitle: '${state.autoDeleteDays} days',
            onTap: () => _showAutoDeleteDialog(state),
          ),
      ],
    );
  }

  Widget _buildSupportSection(SettingsState state) {
    return _buildSection(
      title: 'Support & Information',
      children: [
        _buildActionTile(
          icon: Icons.help_outline,
          title: 'Help & Support',
          subtitle: 'Get help and contact support',
          onTap: () {
            // Navigate to help screen
          },
        ),
        _buildActionTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: 'Read our privacy policy',
          onTap: () {
            // Open privacy policy
          },
        ),
        _buildActionTile(
          icon: Icons.description_outlined,
          title: 'Terms of Service',
          subtitle: 'View terms and conditions',
          onTap: () {
            // Open terms of service
          },
        ),
        _buildActionTile(
          icon: Icons.info_outline,
          title: 'About',
          subtitle: 'App version and information',
          onTap: () => _showAboutDialog(),
        ),
      ],
    );
  }

  Widget _buildDangerZone(SettingsState state) {
    return _buildSection(
      title: 'Account Actions',
      children: [
        _buildActionTile(
          icon: Icons.download_outlined,
          title: 'Export Data',
          subtitle: 'Download your data',
          onTap: () => _showExportDataDialog(),
        ),
        _buildActionTile(
          icon: Icons.refresh_outlined,
          title: 'Reset Settings',
          subtitle: 'Reset all settings to default',
          onTap: () => _showResetSettingsDialog(),
        ),
        _buildActionTile(
          icon: Icons.logout_outlined,
          title: 'Sign Out',
          subtitle: 'Sign out of your account',
          textColor: appTheme.amber600,
          onTap: () => _showSignOutDialog(),
        ),
        _buildActionTile(
          icon: Icons.delete_forever_outlined,
          title: 'Delete Account',
          subtitle: 'Permanently delete your account',
          textColor: appTheme.red500,
          onTap: () => _showDeleteAccountDialog(),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding(all: 16),
            child: Text(
              title,
              style: AppStyle.bold16(color: appTheme.gray700),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: appTheme.gray600),
      title: Text(title, style: AppStyle.medium16()),
      subtitle: Text(subtitle, style: AppStyle.regular14(color: appTheme.gray500)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: appTheme.blue500,
      ),
    );
  }

  Widget _buildSelectTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: appTheme.gray600),
      title: Text(title, style: AppStyle.medium16()),
      subtitle: Text(subtitle, style: AppStyle.regular14(color: appTheme.gray500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: appTheme.gray400),
      onTap: onTap,
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? appTheme.gray600),
      title: Text(title, style: AppStyle.medium16(color: textColor)),
      subtitle: Text(subtitle, style: AppStyle.regular14(color: appTheme.gray500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: appTheme.gray400),
      onTap: onTap,
    );
  }

  // Dialog Methods
  void _showNotificationTypeDialog(SettingsState state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notification Type', style: AppStyle.bold18()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: cubit.availableNotificationTypes.map((type) {
            return RadioListTile<NotificationType>(
              title: Text(_getNotificationTypeText(type)),
              value: type,
              groupValue: state.notificationType,
              onChanged: (value) {
                if (value != null) {
                  cubit.updateNotificationType(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showVideoQualityDialog(SettingsState state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Video Quality', style: AppStyle.bold18()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: cubit.availableVideoQualities.map((quality) {
            return RadioListTile<VideoQuality>(
              title: Text(_getVideoQualityText(quality)),
              value: quality,
              groupValue: state.videoQuality,
              onChanged: (value) {
                if (value != null) {
                  cubit.updateVideoQuality(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLanguageDialog(SettingsState state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Language', style: AppStyle.bold18()),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.availableLanguages.length,
            itemBuilder: (context, index) {
              final language = state.availableLanguages[index];
              return ListTile(
                title: Text(language),
                trailing: state.language == language ? Icon(Icons.check, color: appTheme.blue500) : null,
                onTap: () {
                  cubit.updateLanguage(language);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAutoDeleteDialog(SettingsState state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Auto Delete Period', style: AppStyle.bold18()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: cubit.availableAutoDeleteDays.map((days) {
            return RadioListTile<int>(
              title: Text('$days days'),
              value: days,
              groupValue: state.autoDeleteDays,
              onChanged: (value) {
                if (value != null) {
                  cubit.updateAutoDeleteDays(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cache', style: AppStyle.bold18()),
        content: Text(
          'This will free up storage space but may slow down the app temporarily. Continue?',
          style: AppStyle.regular16(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppStyle.medium14(color: appTheme.gray600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await cubit.clearCache();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cache cleared successfully'),
                    backgroundColor: appTheme.green500,
                  ),
                );
              }
            },
            child: Text('Clear', style: AppStyle.medium14(color: appTheme.blue500)),
          ),
        ],
      ),
    );
  }

  void _showExportDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Data', style: AppStyle.bold18()),
        content: Text(
          'Your data will be exported and downloaded. This may take a few minutes.',
          style: AppStyle.regular16(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppStyle.medium14(color: appTheme.gray600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await cubit.exportData();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Data exported successfully'),
                    backgroundColor: appTheme.green500,
                  ),
                );
              }
            },
            child: Text('Export', style: AppStyle.medium14(color: appTheme.blue500)),
          ),
        ],
      ),
    );
  }

  void _showResetSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Settings', style: AppStyle.bold18()),
        content: Text(
          'This will reset all settings to their default values. This action cannot be undone.',
          style: AppStyle.regular16(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppStyle.medium14(color: appTheme.gray600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await cubit.resetSettings();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Settings reset to default'),
                    backgroundColor: appTheme.green500,
                  ),
                );
              }
            },
            child: Text('Reset', style: AppStyle.medium14(color: appTheme.red500)),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Out', style: AppStyle.bold18()),
        content: Text(
          'Are you sure you want to sign out of your account?',
          style: AppStyle.regular16(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppStyle.medium14(color: appTheme.gray600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await cubit.signOut();
              if (mounted) {
                // context.router.pushAndClearStack('/onboarding');
              }
            },
            child: Text('Sign Out', style: AppStyle.medium14(color: appTheme.amber600)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account', style: AppStyle.bold18()),
        content: Text(
          'This will permanently delete your account and all associated data. This action cannot be undone.',
          style: AppStyle.regular16(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppStyle.medium14(color: appTheme.gray600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await cubit.deleteAccount();
              if (mounted) {
                // context.router.pushAndClearStack('/onboarding');
              }
            },
            child: Text('Delete', style: AppStyle.medium14(color: appTheme.red500)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About', style: AppStyle.bold18()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Highlight Creator', style: AppStyle.bold16()),
            SizedBox(height: 8.h),
            Text('Version 1.0.0', style: AppStyle.regular14(color: appTheme.gray600)),
            SizedBox(height: 16.h),
            Text(
              'Create amazing highlights from your videos with AI-powered editing and easy social media sharing.',
              style: AppStyle.regular14(),
            ),
            SizedBox(height: 16.h),
            Text('© 2024 Highlight Creator', style: AppStyle.regular12(color: appTheme.gray500)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: AppStyle.medium14(color: appTheme.blue500)),
          ),
        ],
      ),
    );
  }

  String _getNotificationTypeText(NotificationType type) {
    switch (type) {
      case NotificationType.all:
        return 'All notifications';
      case NotificationType.important:
        return 'Important only';
      case NotificationType.none:
        return 'None';
    }
  }

  String _getVideoQualityText(VideoQuality quality) {
    switch (quality) {
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
}
