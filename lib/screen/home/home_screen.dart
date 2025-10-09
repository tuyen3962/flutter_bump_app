import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/home/home_cubit.dart';
import 'package:flutter_bump_app/screen/home/home_state.dart';
import 'package:flutter_bump_app/screen/privy_sign/privy_sign_page.dart';

@RoutePage()
class HomePage extends BaseBlocProvider<HomeState, HomeCubit> {
  const HomePage({super.key});

  @override
  Widget buildPage() {
    return const HomeScreen();
  }

  @override
  HomeCubit createCubit() {
    return HomeCubit(
      profileServide: locator.get(),
      accountService: locator.get(),
      privyWalletService: locator.get(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState
    extends BaseBlocNoAppBarPageState<HomeScreen, HomeState, HomeCubit> {
  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, HomeCubit cubit) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0F172A),
                Color(0xFF1E293B),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: padding(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        'Choose Your Path',
                        style: AppStyle.bold20(color: appTheme.whiteText),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: appTheme.whiteText.withSafeOpacity(0.1),
                ),
                Expanded(
                  child: _buildMainContent(cubit),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainContent(HomeCubit cubit) {
    return SingleChildScrollView(
      padding: padding(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          _buildSponsorCard(cubit),
        ],
      ),
    );
  }

  Widget _buildSponsorCard(HomeCubit cubit) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            appTheme.green4AColor.withSafeOpacity(0.1),
            appTheme.green69Color.withSafeOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: appTheme.green4AColor.withSafeOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: padding(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withSafeOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF22C55E).withSafeOpacity(0.3),
                  width: 1.w,
                ),
              ),
              child: Text(
                '🔥 Hot',
                style: AppStyle.regular12(
                  color: const Color(0xFF22C55E),
                ),
              ),
            ),
          ),
          Padding(
            padding: padding(all: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: appTheme.green4AColor.withSafeOpacity(0.2),
                      ),
                      child: Icon(
                        Icons.attach_money,
                        color: appTheme.green4AColor,
                        size: 28.w,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sponsor Sponsor Sponsor Sponsor',
                            style: AppStyle.bold18(color: appTheme.whiteText),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Fund viral sponsorship Fund viral sponsorship Fund viral sponsorship',
                            style: AppStyle.regular12(color: Colors.white60),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 80.w),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Start sponsoring and get guaranteed viral reach with AI verification.',
                  style: AppStyle.regular14(
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(
                      Icons.bar_chart,
                      color: const Color(0xFF22C55E),
                      size: 12.w,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Avg 2.3M views/block',
                      style: AppStyle.regular12(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // context.pushRoute(const SponsorHubRoute());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivySignPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.transparentColor,
                      foregroundColor: appTheme.whiteText,
                      shadowColor: appTheme.green4AColor.withSafeOpacity(0.3),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            appTheme.green4AColor,
                            appTheme.green69Color,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Launch Sponsorship',
                          style: AppStyle.medium16(color: appTheme.whiteText),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
