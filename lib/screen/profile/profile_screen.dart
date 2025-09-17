import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/profile/profile_cubit.dart';
import 'package:flutter_bump_app/widget/dialog/show_logout_confirm_dialog.dart';

import 'profile_state.dart';

@RoutePage()
class ProfilePage extends BaseBlocProvider<ProfileState, ProfileCubit> {
  const ProfilePage({super.key});

  @override
  Widget buildPage() {
    return const ProfileScreen();
  }

  @override
  ProfileCubit createCubit() {
    return ProfileCubit();
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends BaseBlocNoAppBarPageState<ProfileScreen, ProfileState, ProfileCubit> {
  @override
  String get title => 'Profile';

  @override
  Widget buildBody(BuildContext context, ProfileCubit cubit) {
    final userInfo = {
      'fullName': 'John Doe',
      'email': 'john.doe@email.com',
      'birthYear': '1990',
      'gender': 'Male',
      'location': 'San Francisco, CA',
      'joinDate': 'January 2024',
      'phoneNumber': '+1 (555) 123-4567',
      'bio': 'Passionate pickleball player and highlight creator'
    };

    return Scaffold(
      backgroundColor: appTheme.alpha,
      body: Column(
        children: [
          Container(
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
                  SizedBox(width: 32.w, height: 32.h),
                  Expanded(
                    child: Text(
                      'Profile',
                      style: AppStyle.bold18(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pushRoute(const UpdateProfileRoute()),
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: appTheme.transparentColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.edit, size: 18, color: appTheme.gray600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: padding(all: 24),
                    decoration: BoxDecoration(
                      color: appTheme.alpha,
                      border: Border(
                        bottom: BorderSide(color: appTheme.gray200, width: 1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 96.w,
                          height: 96.h,
                          decoration: BoxDecoration(
                            color: appTheme.blue100,
                            borderRadius: BorderRadius.circular(48),
                          ),
                          child: Center(
                            child: Text(
                              'JD',
                              style: AppStyle.bold24(color: appTheme.blue600),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          userInfo['fullName']!,
                          style: AppStyle.bold20(),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          userInfo['email']!,
                          style: AppStyle.regular16(color: appTheme.gray500),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          userInfo['bio']!,
                          style: AppStyle.regular14(color: appTheme.gray600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: padding(all: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: AppStyle.bold18(),
                        ),
                        SizedBox(height: 16.h),
                        _buildInfoItem('Full Name', userInfo['fullName']!),
                        _buildInfoItem('Email', userInfo['email']!),
                        _buildInfoItem('Phone', userInfo['phoneNumber']!),
                        _buildInfoItem('Year of Birth', userInfo['birthYear']!),
                        _buildInfoItem('Gender', userInfo['gender']!),
                        _buildInfoItemWithIcon(
                          'Location',
                          userInfo['location']!,
                          Icons.location_on,
                        ),
                        _buildInfoItemWithIcon(
                          'Member Since',
                          userInfo['joinDate']!,
                          Icons.calendar_today,
                          isLast: true,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'Account',
                          style: AppStyle.bold18(),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          margin: padding(bottom: 12.h),
                          padding: padding(all: 12),
                          decoration: BoxDecoration(
                            color: appTheme.alpha,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: appTheme.gray300),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: appTheme.red500,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    'YT',
                                    style: AppStyle.bold12(color: appTheme.alpha),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'YouTube',
                                      style: AppStyle.medium16(),
                                    ),
                                    Text(
                                      'Connected',
                                      style: AppStyle.regular12(color: appTheme.gray500),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Connected',
                                style: AppStyle.medium14(color: appTheme.green600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: padding(bottom: 24.h),
                          padding: padding(all: 12),
                          decoration: BoxDecoration(
                            color: appTheme.alpha,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: appTheme.gray300),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: appTheme.blackColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    'TT',
                                    style: AppStyle.bold12(color: appTheme.alpha),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TikTok',
                                      style: AppStyle.medium16(),
                                    ),
                                    Text(
                                      'Not connected',
                                      style: AppStyle.regular12(color: appTheme.gray500),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Connect',
                                  style: AppStyle.medium14(color: appTheme.blue600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: padding(all: 16),
                          margin: padding(bottom: 12.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                appTheme.blue50,
                                Color(0xFFF3E8FF),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: appTheme.gray300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subscription',
                                    style: AppStyle.bold16(),
                                  ),
                                  Container(
                                    padding: padding(horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF3E8FF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Pro',
                                      style: AppStyle.medium12(color: Color(0xFF7C3AED)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Pro Plan - Unlimited highlights, advanced editing, and priority processing',
                                style: AppStyle.regular14(color: appTheme.gray600),
                              ),
                              SizedBox(height: 12.h),
                              GestureDetector(
                                onTap: () => context.pushRoute(const SubscriptionRoute()),
                                child: Text(
                                  'Manage Subscription',
                                  style: AppStyle.medium14(color: Color(0xFF7C3AED)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildSettingsButton(
                          'Settings',
                          () => context.pushRoute(const SettingsRoute()),
                        ),
                        SizedBox(height: 12.h),
                        _buildSettingsButton('Help & Support', () {}),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: () {
                              showLogoutConfirmDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appTheme.red500,
                              foregroundColor: appTheme.alpha,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Log Out',
                              style: AppStyle.medium16(color: appTheme.alpha),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {bool isLast = false}) {
    return Container(
      padding: padding(vertical: 12.h),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: appTheme.gray100, width: 1),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppStyle.regular16(color: appTheme.gray600),
          ),
          Text(
            value,
            style: AppStyle.medium16(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItemWithIcon(String label, String value, IconData icon, {bool isLast = false}) {
    return Container(
      padding: padding(vertical: 12.h),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: appTheme.gray100, width: 1),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: appTheme.gray600,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: AppStyle.regular16(color: appTheme.gray600),
              ),
            ],
          ),
          Text(
            value,
            style: AppStyle.medium16(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsButton(String title, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: appTheme.gray900,
          side: BorderSide(color: appTheme.gray300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: AppStyle.medium16(),
          ),
        ),
      ),
    );
  }
}
