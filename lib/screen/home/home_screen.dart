import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/home/home_cubit.dart';
import 'package:flutter_bump_app/screen/home/home_state.dart';

@RoutePage()
class HomePage extends BaseBlocProvider<HomeState, HomeCubit> {
  const HomePage({super.key});

  @override
  Widget buildPage() {
    return const HomeScreen();
  }

  @override
  HomeCubit createCubit() {
    return HomeCubit();
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
  String get title => 'Home';

  @override
  Widget buildBody(BuildContext context, HomeCubit cubit) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.gray50,
          body: Column(
            children: [
              _buildHeader(state),
              Expanded(
                child: SingleChildScrollView(
                  padding: padding(all: 12),
                  child: Column(
                    children: [
                      // Featured Video Card
                      _buildFeaturedVideoCard(),

                      SizedBox(height: 16.h),

                      // Record New Game
                      _buildRecordNewGameCard(),

                      SizedBox(height: 16.h),

                      // Recent Activity
                      _buildRecentActivity(state),
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

  Widget _buildHeader(HomeState state) {
    return Container(
      padding: padding(all: 12),
      decoration: BoxDecoration(
        color: appTheme.alpha,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1724435811349-32d27f4d5806?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHhwZXJzb24lMjBwcm9maWxlJTIwcGhvdG98ZW58MXx8fHwxNzU3OTI1NDMxfDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral',
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: appTheme.blue100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'A',
                              style: AppStyle.medium16(color: appTheme.blue600),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good afternoon, Alex!',
                      style: AppStyle.medium16(),
                    ),
                    Row(
                      children: [
                        Text(
                          '📹 24 highlights',
                          style: AppStyle.regular12(color: appTheme.blue500),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          '🔥 8 this month',
                          style: AppStyle.regular12(color: appTheme.amber500),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: padding(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: appTheme.yellow100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '⚡',
                    style: AppStyle.regular14(color: appTheme.yellow600),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '142',
                    style: AppStyle.medium12(color: appTheme.yellow800),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedVideoCard() {
    return GestureDetector(
      onTap: () => context.pushRoute(HighlightPlayerRoute()),
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.alpha,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: appTheme.gray200.withSafeOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Thumbnail
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 128.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1629737664080-75010be40a41?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHhiYXNrZXRiYWxsJTIwZ2FtZSUyMGFjdGlvbiUyMHNob3R8ZW58MXx8fHwxNzU3OTI1NDI4fDA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral',
                      width: double.infinity,
                      height: 128.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 128.h,
                          color: appTheme.gray200,
                          child: Icon(
                            Icons.image,
                            size: 48,
                            color: appTheme.gray400,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Play button overlay
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: appTheme.alpha,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: appTheme.blackColor.withSafeOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 24,
                          color: appTheme.gray800,
                        ),
                      ),
                    ),
                  ),
                ),

                // Duration
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: padding(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.blackColor.withSafeOpacity(0.75),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '3:45',
                      style: AppStyle.regular12(color: appTheme.alpha),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: padding(all: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basketball Championship Finals - Best Plays',
                    style: AppStyle.medium14(),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        '📅 Today',
                        style: AppStyle.regular12(color: appTheme.gray500),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '👁 1247 views',
                        style: AppStyle.regular12(color: appTheme.gray500),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        '❤️ 89 likes',
                        style: AppStyle.regular12(color: appTheme.gray500),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        padding: padding(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: appTheme.red100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'YouTube',
                          style: AppStyle.regular12(color: appTheme.red800),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: padding(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: appTheme.blackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'TikTok',
                          style: AppStyle.regular12(color: appTheme.alpha),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordNewGameCard() {
    return GestureDetector(
      onTap: () => context.router.pushNamed('/create'),
      child: Container(
        padding: padding(all: 12),
        decoration: BoxDecoration(
          color: appTheme.alpha,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: appTheme.amber100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '📹',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Record New Game',
                    style: AppStyle.medium14(),
                  ),
                  Text(
                    'Capture your best moments and create highlights',
                    style: AppStyle.regular12(color: appTheme.gray500),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: appTheme.gray400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(HomeState state) {
    final recentActivity = [
      {
        'id': 1,
        'title': 'Soccer Match Highlights',
        'status': 'Processing complete',
        'time': '2 hours ago',
        'icon': '✓',
        'iconColor': appTheme.green500,
      },
      {
        'id': 2,
        'title': 'Tennis Tournament Upload',
        'status': 'Ready to edit',
        'time': '5 hours ago',
        'icon': '📹',
        'iconColor': appTheme.blue500,
      },
    ];

    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activity',
              style: AppStyle.medium14(),
            ),
            GestureDetector(
              onTap: () => context.pushRoute(const ViewAllActivityRoute()),
              child: Text(
                'View All',
                style: AppStyle.regular12(color: appTheme.blue500),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Activity items
        Column(
          children: recentActivity.map((activity) {
            return Container(
              margin: padding(bottom: 8.h),
              padding: padding(all: 10),
              decoration: BoxDecoration(
                color: appTheme.alpha,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: activity['iconColor'] as Color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        activity['icon'] as String,
                        style: AppStyle.regular14(color: appTheme.alpha),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['title'] as String,
                          style: AppStyle.regular12(),
                        ),
                        Text(
                          activity['status'] as String,
                          style: AppStyle.regular12(color: appTheme.gray500),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    activity['time'] as String,
                    style: AppStyle.regular12(color: appTheme.gray500),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
