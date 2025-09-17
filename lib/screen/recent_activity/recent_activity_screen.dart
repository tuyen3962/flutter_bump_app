import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/screen/recent_activity/recent_activity_cubit.dart';

import 'recent_activity_state.dart';

@RoutePage()
class RecentActivityPage
    extends BaseBlocProvider<RecentActivityState, RecentActivityCubit> {
  const RecentActivityPage({super.key});

  @override
  Widget buildPage() {
    return const RecentActivityScreen();
  }

  @override
  RecentActivityCubit createCubit() {
    return RecentActivityCubit();
  }
}

class RecentActivityScreen extends StatefulWidget {
  const RecentActivityScreen({super.key});

  @override
  State<RecentActivityScreen> createState() => RecentActivityScreenState();
}

class RecentActivityScreenState extends BaseBlocPageState<RecentActivityScreen,
    RecentActivityState, RecentActivityCubit> {
  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  String get title => 'Recent Activity';

  @override
  Widget buildBody(BuildContext context, RecentActivityCubit cubit) {
    return RefreshIndicator(
      onRefresh: () async {},
      // onRefresh: () => context.read<RecentActivityCubit>().refreshActivities(),
      child: Column(
        children: [
          // _buildStatsSection(context, cubit.state),
          // _buildFilterTabs(context, cubit.state),
          // Expanded(
          //   child: _buildActivitiesList(context, cubit.state),
          // ),
        ],
      ),
    );
  }
}
