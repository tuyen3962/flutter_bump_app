import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/view_all_activity/view_all_activity_cubit.dart';
import 'package:flutter_bump_app/screen/view_all_activity/view_all_activity_state.dart';

@RoutePage()
class ViewAllActivityPage extends BaseBlocProvider<ViewAllActivityState, ViewAllActivityCubit> {
  const ViewAllActivityPage({super.key});

  @override
  Widget buildPage() {
    return const ViewAllActivityScreen();
  }

  @override
  ViewAllActivityCubit createCubit() {
    return ViewAllActivityCubit();
  }
}

class ViewAllActivityScreen extends StatefulWidget {
  const ViewAllActivityScreen({super.key});

  @override
  State<ViewAllActivityScreen> createState() => ViewAllActivityScreenState();
}

class ViewAllActivityScreenState
    extends BaseBlocNoAppBarPageState<ViewAllActivityScreen, ViewAllActivityState, ViewAllActivityCubit> {
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
  Widget buildBody(BuildContext context, ViewAllActivityCubit cubit) {
    return BlocBuilder<ViewAllActivityCubit, ViewAllActivityState>(
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

              // Activities List
              Expanded(
                child: _buildActivitiesList(state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
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
              onTap: () => context.router.pop(),
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
                'Recent Activity',
                style: AppStyle.bold18(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 32.w), // Spacer
          ],
        ),
      ),
    );
  }

  Widget _buildStatsBar(ViewAllActivityState state) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              '${state.processingCount}',
              'Processing',
              appTheme.blue500,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              '${state.completedCount}',
              'Completed',
              appTheme.green500,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              '${state.failedCount}',
              'Failed',
              appTheme.red500,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              '${state.totalCount}',
              'Total',
              appTheme.gray700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyle.bold18(color: color),
        ),
        Text(
          label,
          style: AppStyle.regular12(color: appTheme.gray600),
        ),
      ],
    );
  }

  Widget _buildFilterTabs(ViewAllActivityState state) {
    final filters = [
      {'key': ActivityFilter.all, 'label': 'All'},
      {'key': ActivityFilter.processing, 'label': 'Processing'},
      {'key': ActivityFilter.completed, 'label': 'Completed'},
      {'key': ActivityFilter.failed, 'label': 'Failed'},
    ];

    return Container(
      padding: padding(all: 16),
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
              padding: EdgeInsets.only(right: 12.w),
              child: GestureDetector(
                onTap: () => cubit.setFilter(filter['key'] as ActivityFilter),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? appTheme.blue500 : appTheme.transparentColor,
                    border: Border.all(
                      color: isSelected ? appTheme.blue500 : appTheme.gray300,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    filter['label'] as String,
                    style: AppStyle.medium12(
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

  Widget _buildActivitiesList(ViewAllActivityState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: appTheme.blue500,
        ),
      );
    }

    final filteredActivities = state.filteredActivities;

    if (filteredActivities.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: cubit.refreshActivity,
      color: appTheme.blue500,
      child: ListView.builder(
        padding: padding(all: 16),
        itemCount: filteredActivities.length,
        itemBuilder: (context, index) {
          final activity = filteredActivities[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildActivityItem(activity),
          );
        },
      ),
    );
  }

  Widget _buildActivityItem(ActivityItem activity) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: appTheme.gray200),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray200.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Activity Icon
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: _getStatusColor(activity.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    activity.icon ?? cubit.getStatusIcon(activity.status),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: AppStyle.medium14(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          cubit.getStatusText(activity.status),
                          style: AppStyle.regular12(color: _getStatusColor(activity.status)),
                        ),
                        if (activity.duration != null) ...[
                          Text(
                            ' • ',
                            style: AppStyle.regular12(color: appTheme.gray500),
                          ),
                          Text(
                            activity.duration!,
                            style: AppStyle.regular12(color: appTheme.gray500),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Time and Action
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    activity.time,
                    style: AppStyle.regular12(color: appTheme.gray500),
                  ),
                  if (activity.status == ActivityStatus.failed) ...[
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => cubit.retryFailedActivity(activity.id),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: appTheme.blue500,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Retry',
                          style: AppStyle.regular10(color: appTheme.alpha),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),

          // Progress bar for processing/uploading activities
          if ((activity.status == ActivityStatus.processing || activity.status == ActivityStatus.uploading) &&
              activity.progress != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: appTheme.gray200,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: activity.progress! / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _getStatusColor(activity.status),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${activity.progress!.round()}%',
                  style: AppStyle.regular12(color: appTheme.gray600),
                ),
              ],
            ),
          ],
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
              child: Icon(
                Icons.analytics_outlined,
                size: 32,
                color: appTheme.gray400,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No activities found',
              style: AppStyle.medium16(color: appTheme.gray600),
            ),
            SizedBox(height: 8.h),
            Text(
              'Upload videos to see processing status',
              style: AppStyle.regular14(color: appTheme.gray400),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => context.router.pushNamed('/create'),
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

  Color _getStatusColor(ActivityStatus status) {
    switch (status) {
      case ActivityStatus.processing:
      case ActivityStatus.uploading:
        return appTheme.blue500;
      case ActivityStatus.completed:
        return appTheme.green500;
      case ActivityStatus.failed:
        return appTheme.red500;
      case ActivityStatus.queued:
        return appTheme.amber500;
    }
  }
}
