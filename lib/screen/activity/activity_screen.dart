import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/activity/activity_cubit.dart';

import 'activity_state.dart';

@RoutePage()
class ActivityPage extends BaseBlocProvider<ActivityState, ActivityCubit> {
  const ActivityPage({super.key});

  @override
  Widget buildPage() {
    return const ActivityScreen();
  }

  @override
  ActivityCubit createCubit() {
    return ActivityCubit();
  }
}

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => ActivityScreenState();
}

class ActivityScreenState extends BaseBlocNoAppBarPageState<ActivityScreen, ActivityState, ActivityCubit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeActivity();
    });
  }

  @override
  String get title => 'Recent Activity';

  @override
  Widget buildBody(BuildContext context, ActivityCubit cubit) {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.gray50,
          body: Column(
            children: [
              // Header
              _buildHeader(),

              // Stats Bar
              _buildStatsBar(state),

              // Filter Tabs
              _buildFilterTabs(state),

              // Videos List
              Expanded(
                child: _buildVideosList(state),
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
      padding: padding(all: 12),
      decoration: BoxDecoration(
        color: appTheme.alpha,
      ),
      child: SafeArea(
        child: Text(
          'Recent Activity',
          style: AppStyle.bold18(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildStatsBar(ActivityState state) {
    return Container(
      width: double.infinity,
      padding: padding(all: 12),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '${state.processingCount}',
                  style: AppStyle.bold18(color: appTheme.blue500),
                ),
                Text(
                  'Processing',
                  style: AppStyle.regular12(color: appTheme.gray600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${state.completedCount}',
                  style: AppStyle.bold18(color: appTheme.green500),
                ),
                Text(
                  'Completed',
                  style: AppStyle.regular12(color: appTheme.gray600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '${state.totalCount}',
                  style: AppStyle.bold18(color: appTheme.blue600),
                ),
                Text(
                  'Total',
                  style: AppStyle.regular12(color: appTheme.gray600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(ActivityState state) {
    final filters = [
      {'key': ActivityFilter.all, 'label': 'All'},
      {'key': ActivityFilter.processing, 'label': 'Processing'},
      {'key': ActivityFilter.completed, 'label': 'Completed'},
      {'key': ActivityFilter.failed, 'label': 'Failed'},
    ];

    return Container(
      padding: padding(all: 12),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = state.currentFilter == filter['key'];
            return Padding(
              padding: padding(right: 8.w),
              child: GestureDetector(
                onTap: () => cubit.setFilter(filter['key'] as ActivityFilter),
                child: Container(
                  padding: padding(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? appTheme.blue500 : appTheme.transparentColor,
                    border: Border.all(
                      color: isSelected ? appTheme.blue500 : appTheme.gray300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    filter['label'] as String,
                    style: AppStyle.regular12(
                      color: isSelected ? appTheme.alpha : appTheme.gray700,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildVideosList(ActivityState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: appTheme.blue500,
        ),
      );
    }

    final filteredVideos = state.filteredVideos;

    if (filteredVideos.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: cubit.refreshActivity,
      color: appTheme.blue500,
      child: ListView.builder(
        padding: padding(all: 12),
        itemCount: filteredVideos.length,
        itemBuilder: (context, index) {
          final video = filteredVideos[index];
          return Padding(
            padding: padding(bottom: 12.h),
            child: _buildVideoItem(video),
          );
        },
      ),
    );
  }

  Widget _buildVideoItem(VideoItem video) {
    return GestureDetector(
      onTap: () {
        if (video.status == VideoStatus.completed) {
          // Navigate to player
          // context.router.push(PlayerRoute());
        }
      },
      child: Container(
        padding: padding(all: 12),
        decoration: BoxDecoration(
          color: appTheme.alpha,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: appTheme.gray200.withSafeOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            _buildThumbnail(video),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: AppStyle.medium14(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        video.timeAgo,
                        style: AppStyle.regular12(color: appTheme.gray500),
                      ),
                      _buildStatusBadge(video),
                    ],
                  ),
                  if (video.status == VideoStatus.processing || video.status == VideoStatus.uploading)
                    _buildProgressBar(video),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(VideoItem video) {
    return Stack(
      children: [
        Container(
          width: 64.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: appTheme.gray300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'IMG',
              style: AppStyle.regular12(color: appTheme.gray600),
            ),
          ),
        ),

        // Duration overlay
        if (video.duration != null)
          Positioned(
            bottom: 4.h,
            right: 4.w,
            child: Container(
              padding: padding(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: appTheme.blackColor.withSafeOpacity(0.75),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                video.duration!,
                style: AppStyle.regular10(color: appTheme.alpha),
              ),
            ),
          ),

        // Processing overlay
        if (video.status == VideoStatus.processing)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.blue500.withSafeOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(appTheme.blue500),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusBadge(VideoItem video) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (video.status) {
      case VideoStatus.processing:
        backgroundColor = appTheme.blue100;
        textColor = appTheme.blue800;
        text = 'Processing ${video.progress.round()}%';
        break;
      case VideoStatus.completed:
        backgroundColor = appTheme.green100;
        textColor = appTheme.green800;
        text = 'Completed';
        break;
      case VideoStatus.failed:
        backgroundColor = appTheme.red100;
        textColor = appTheme.red800;
        text = '❌ Failed';
        break;
      case VideoStatus.queued:
        backgroundColor = appTheme.gray100;
        textColor = appTheme.gray800;
        text = '⏳ Queued';
        break;
      case VideoStatus.uploading:
        backgroundColor = appTheme.amber100;
        textColor = appTheme.amber800;
        text = '☁️ Uploading';
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
        style: AppStyle.regular10(color: textColor),
      ),
    );
  }

  Widget _buildProgressBar(VideoItem video) {
    return Padding(
      padding: padding(top: 8.h),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 6.h,
            decoration: BoxDecoration(
              color: appTheme.gray200,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: video.progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: appTheme.blue500,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: padding(all: 32),
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
              child: Center(
                child: Text(
                  '📹',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No videos found',
              style: AppStyle.medium16(color: appTheme.gray600),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to upload
                  // context.router.push(UploadRoute());
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
                  'Upload New Video',
                  style: AppStyle.medium14(color: appTheme.alpha),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
