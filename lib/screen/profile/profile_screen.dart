import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/stream/base_stream_builder.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/data/model/user.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/profile/profile_cubit.dart';
import 'package:flutter_bump_app/screen/profile/profile_state.dart';
import 'package:flutter_bump_app/widget/line_widget.dart';

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

class ProfileScreenState extends BaseBlocNoAppBarPageState<ProfileScreen,
    ProfileState, ProfileCubit> {
  @override
  String get title => 'Profile';

  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, ProfileCubit cubit) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: appTheme.greenF4Color,
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(cubit),
                Expanded(
                  child: _buildProfileContent(state, cubit),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(ProfileCubit cubit) {
    return Container(
      padding: padding(all: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: context.back,
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: appTheme.green800Color.withSafeOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.arrow_back,
                color: appTheme.green800Color,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Profile',
              textAlign: TextAlign.center,
              style: AppStyle.bold18(color: appTheme.green2DColor),
            ),
          ),
          GestureDetector(
            onTap: () => context.pushRoute(const UpdateProfileRoute()),
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: appTheme.green800Color.withSafeOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.edit_outlined,
                color: appTheme.green800Color,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(ProfileState state, ProfileCubit cubit) {
    return BaseStreamBuilder(
      controller: cubit.accountService.myAccount,
      builder: (user) {
        return SingleChildScrollView(
          padding: padding(all: 24),
          child: Column(
            children: [
              // Profile Picture & Basic Info
              _buildProfileHeader(state, user),
              const LineWidget(),
              SizedBox(height: 24.h),
              // Personal Information
              _buildPersonalInformation(state, user),
              SizedBox(height: 24.h),
              // Account Section
              _buildAccountSection(state, cubit),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(ProfileState state, User? user) {
    return Column(
      children: [
        Container(
          width: 96.w,
          height: 96.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                appTheme.green81Color.withSafeOpacity(0.8),
                appTheme.green69Color.withSafeOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: appTheme.green81Color.withSafeOpacity(0.25),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: appTheme.green300.withSafeOpacity(0.3),
              width: 1,
            ),
          ),
          child: Center(
            child: Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    appTheme.green200Color.withSafeOpacity(0.5),
                    appTheme.emerald200Color.withSafeOpacity(0.5),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  'A',
                  style: AppStyle.bold20(color: appTheme.green800Color),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          user?.name ?? '',
          style: AppStyle.bold20(color: appTheme.green2DColor),
        ),
        SizedBox(height: 4.h),
        Text(
          user?.email ?? '',
          style: AppStyle.regular16(color: appTheme.green3DColor),
        ),
      ],
    );
  }

  Widget _buildPersonalInformation(ProfileState state, User? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: AppStyle.bold18(color: appTheme.green2DColor),
        ),
        SizedBox(height: 12.h),

        // Full Name
        _buildInfoRow('Full Name', user?.name ?? ''),

        // Gender
        _buildInfoRow('Gender', user?.gender?.name ?? ''),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: padding(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.green300.withSafeOpacity(0.5),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppStyle.regular16(color: appTheme.green3DColor),
            ),
          ),
          Text(
            value,
            style: AppStyle.medium16(color: appTheme.green2DColor),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(ProfileState state, ProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: AppStyle.bold18(color: appTheme.green2DColor),
        ),
        SizedBox(height: 16.h),
        _buildPlatformConnection(
          'YouTube',
          'YT',
          appTheme.redColor,
          'Connected',
          true,
        ),
        SizedBox(height: 12.h),
        _buildPlatformConnection(
          'TikTok',
          'TT',
          appTheme.blackColor,
          'Connected',
          true,
        ),
        SizedBox(height: 12.h),

        // SOL Wallet
        _buildWalletConnection(cubit),
        SizedBox(height: 12.h),

        // Settings Button
        _buildActionButton(
          'Settings',
          Icons.settings_outlined,
          () {},
        ),
        SizedBox(height: 12.h),
        // Help & Support Button
        _buildActionButton(
          'Help & Support',
          Icons.help_outline,
          () {},
        ),
      ],
    );
  }

  Widget _buildPlatformConnection(
    String platformName,
    String shortName,
    Color iconColor,
    String status,
    bool isConnected,
  ) {
    return Container(
      padding: padding(all: 12.w),
      decoration: BoxDecoration(
        color: appTheme.whiteText.withSafeOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: appTheme.green300.withSafeOpacity(0.5),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          // Platform Icon
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                shortName,
                style: AppStyle.bold12(color: appTheme.whiteText),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              platformName,
              style: AppStyle.medium16(color: appTheme.green2DColor),
            ),
          ),
          Text(
            status,
            style: AppStyle.medium14(
              color: isConnected ? appTheme.green600 : appTheme.redColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletConnection(ProfileCubit cubit) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: padding(all: 12.w),
        decoration: BoxDecoration(
          color: appTheme.whiteText.withSafeOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: appTheme.green300.withSafeOpacity(0.5),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    appTheme.green81Color,
                    appTheme.green69Color,
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.account_balance_wallet_outlined,
                color: appTheme.whiteText,
                size: 16,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'SOL Wallet',
                style: AppStyle.medium16(color: appTheme.green2DColor),
              ),
            ),
            Text(
              'Not Connected',
              style: AppStyle.medium14(color: appTheme.red600Color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding(all: 12.w),
        decoration: BoxDecoration(
          color: appTheme.whiteText.withSafeOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: appTheme.green300.withSafeOpacity(0.5),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: appTheme.green2DColor,
              size: 20,
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: AppStyle.medium16(color: appTheme.green2DColor),
            ),
          ],
        ),
      ),
    );
  }
}
