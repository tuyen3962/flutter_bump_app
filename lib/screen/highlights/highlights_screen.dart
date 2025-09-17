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
import 'package:flutter_bump_app/screen/highlights/highlights_cubit.dart';

import 'highlights_state.dart';

@RoutePage()
class HighlightsPage extends BaseBlocProvider<HighlightsState, HighlightsCubit> {
  const HighlightsPage({super.key});

  @override
  Widget buildPage() {
    return const HighlightsScreen();
  }

  @override
  HighlightsCubit createCubit() {
    return HighlightsCubit();
  }
}

class HighlightsScreen extends StatefulWidget {
  const HighlightsScreen({super.key});

  @override
  State<HighlightsScreen> createState() => HighlightsScreenState();
}

class HighlightsScreenState extends BaseBlocNoAppBarPageState<HighlightsScreen, HighlightsState, HighlightsCubit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeHighlights();
    });
  }

  @override
  String get title => 'My Highlights';

  @override
  Widget buildBody(BuildContext context, HighlightsCubit cubit) {
    return BlocBuilder<HighlightsCubit, HighlightsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.alpha,
          body: Column(
            children: [
              // Header
              _buildHeader(),

              // Stats Overview
              _buildStatsOverview(state),

              // Filter Tags
              _buildFilterTags(state),

              // Highlights List
              Expanded(
                child: _buildHighlightsList(state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: SafeArea(
        child: Text(
          'My Highlights',
          style: AppStyle.bold18(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildStatsOverview(HighlightsState state) {
    return Container(
      padding: padding(vertical: 16),
      decoration: BoxDecoration(
        color: appTheme.gray50,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('${state.totalHighlights}', 'Highlights'),
          _buildStatItem('${state.totalViews}', 'Total Views'),
          _buildStatItem('${state.totalLikes}', 'Total Likes'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyle.bold20(),
        ),
        Text(
          label,
          style: AppStyle.regular12(color: appTheme.gray500),
        ),
      ],
    );
  }

  Widget _buildFilterTags(HighlightsState state) {
    final filters = [
      {'key': HighlightFilter.all, 'label': 'All', 'color': appTheme.blue500},
      {'key': HighlightFilter.posted, 'label': 'Posted', 'color': appTheme.green500},
      {'key': HighlightFilter.notPosted, 'label': 'Not Posted', 'color': appTheme.gray500},
    ];

    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.gray50,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: Row(
        children: filters.map((filter) {
          final isSelected = state.currentFilter == filter['key'];
          final color = filter['color'] as Color;

          return Padding(
            padding: padding(right: 8.w),
            child: GestureDetector(
              onTap: () => cubit.setFilter(filter['key'] as HighlightFilter),
              child: Container(
                padding: padding(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isSelected ? color : appTheme.alpha,
                  border: Border.all(
                    color: isSelected ? color : appTheme.gray300,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  filter['label'] as String,
                  style: AppStyle.regular14(
                    color: isSelected ? appTheme.alpha : appTheme.gray600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHighlightsList(HighlightsState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: appTheme.blue500,
        ),
      );
    }

    final filteredHighlights = state.filteredHighlights;

    if (filteredHighlights.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: cubit.refreshHighlights,
      color: appTheme.blue500,
      child: ListView.builder(
        padding: padding(all: 16),
        itemCount: filteredHighlights.length,
        itemBuilder: (context, index) {
          final highlight = filteredHighlights[index];
          return Padding(
            padding: padding(bottom: 16.h),
            child: _buildHighlightItem(highlight),
          );
        },
      ),
    );
  }

  Widget _buildHighlightItem(Highlight highlight) {
    return GestureDetector(
      onTap: () => context.pushRoute(HighlightPlayerRoute()),
      child: Container(
        padding: padding(all: 16),
        decoration: BoxDecoration(
          color: appTheme.alpha,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: appTheme.gray200),
          boxShadow: [
            BoxShadow(
              color: appTheme.gray200.withSafeOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHighlightHeader(highlight),
            SizedBox(height: 12.h),

            // Thumbnail
            _buildThumbnail(highlight),

            // Stats and platforms (only for posted)
            if (highlight.socialPostStatus == SocialPostStatus.posted) _buildStatsAndPlatforms(highlight),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightHeader(Highlight highlight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                highlight.title,
                style: AppStyle.medium16(),
              ),
              SizedBox(height: 4.h),
              Text(
                highlight.createdAt,
                style: AppStyle.regular14(color: appTheme.gray500),
              ),
            ],
          ),
        ),
        _buildStatusBadge(highlight.socialPostStatus),
      ],
    );
  }

  Widget _buildStatusBadge(SocialPostStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case SocialPostStatus.posted:
        backgroundColor = appTheme.green100;
        textColor = appTheme.green800;
        text = 'Posted';
        break;
      case SocialPostStatus.notPosted:
        backgroundColor = appTheme.gray100;
        textColor = appTheme.gray800;
        text = 'Not Posted';
        break;
    }

    return Container(
      padding: padding(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppStyle.regular12(color: textColor),
      ),
    );
  }

  Widget _buildThumbnail(Highlight highlight) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 128.h,
          decoration: BoxDecoration(
            color: appTheme.gray200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Play button overlay
              Center(
                child: Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: appTheme.alpha.withSafeOpacity(0.8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 24,
                    color: appTheme.gray600,
                  ),
                ),
              ),
              // Duration badge
              Positioned(
                bottom: 8.h,
                right: 8.w,
                child: Container(
                  padding: padding(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: appTheme.blackColor.withSafeOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    highlight.duration,
                    style: AppStyle.regular12(color: appTheme.alpha),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsAndPlatforms(Highlight highlight) {
    return Padding(
      padding: padding(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Stats
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    size: 16,
                    color: appTheme.gray500,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${highlight.views}',
                    style: AppStyle.regular14(color: appTheme.gray500),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 16,
                    color: appTheme.gray500,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${highlight.likes}',
                    style: AppStyle.regular14(color: appTheme.gray500),
                  ),
                ],
              ),
            ],
          ),

          // Platform tags
          if (highlight.platforms != null && highlight.platforms!.isNotEmpty)
            Row(
              children: highlight.platforms!.map((platform) {
                return Padding(
                  padding: padding(left: 4.w),
                  child: _buildPlatformTag(platform),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildPlatformTag(String platform) {
    Color backgroundColor;
    Color textColor;

    switch (platform.toLowerCase()) {
      case 'youtube':
        backgroundColor = appTheme.red100;
        textColor = appTheme.red800;
        break;
      case 'tiktok':
        backgroundColor = appTheme.blackColor;
        textColor = appTheme.alpha;
        break;
      case 'instagram':
        backgroundColor = Color(0xFFFCE7F3);
        textColor = Color(0xFF9D174D);
        break;
      default:
        backgroundColor = appTheme.blue100;
        textColor = appTheme.blue800;
        break;
    }

    return Container(
      padding: padding(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        platform,
        style: AppStyle.regular12(color: textColor),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: padding(all: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: appTheme.gray200,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(
                Icons.video_library,
                size: 32,
                color: appTheme.gray400,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No highlights yet',
              style: AppStyle.bold18(),
            ),
            SizedBox(height: 8.h),
            Text(
              'Create your first highlight from your pickleball videos',
              style: AppStyle.regular14(color: appTheme.gray500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to create highlight
                  // context.router.push(CreateHighlightRoute());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appTheme.blue500,
                  foregroundColor: appTheme.alpha,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Create Highlight',
                  style: AppStyle.medium16(color: appTheme.alpha),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
