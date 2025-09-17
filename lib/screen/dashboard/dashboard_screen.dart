import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/dashboard/dashboard_cubit.dart';
import 'package:flutter_bump_app/utils/extension/context_ext.dart';

import 'dashboard_state.dart';

@RoutePage()
class DashboardPage extends BaseBlocProvider<DashboardState, DashboardCubit> {
  const DashboardPage({super.key});

  @override
  Widget buildPage() {
    return const DashboardScreen();
  }

  @override
  DashboardCubit createCubit() {
    return DashboardCubit();
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends BaseBlocNoAppBarPageState<DashboardScreen,
    DashboardState, DashboardCubit> {
  @override
  String get title => 'Dashboard';

  @override
  Color get backgroundColor => appTheme.background;

  @override
  Widget buildBody(BuildContext context, DashboardCubit cubit) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildFeaturedVideo(context),
            const SizedBox(height: 20),
            _buildRecordNewGameCard(context),
            const SizedBox(height: 20),
            _buildRecentActivity(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://via.placeholder.com/48')),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good afternoon, userName!',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.video_library, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'totalHighlights highlights',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.local_fire_department,
                      size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'monthlyHighlights this month',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              color: appTheme.yellow100,
              borderRadius: BorderRadius.circular(12)),
          child: Text('totalScore', style: AppStyle.medium16()),
        ),
      ],
    ).pad(all: 20);
  }

  Widget _buildFeaturedVideo(BuildContext context) {
    // if (state.featuredVideo == null) return const SizedBox();

    // final video = state.featuredVideo!;
    // final isPlaying = state is DashboardVideoPlaying && state.isPlaying;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      // image: DecorationImage(
                      //   image: NetworkImage('thumbnailUrl'),
                      //   fit: BoxFit.cover,
                      //   onError: (_, __) {},
                      // ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        // onTap: () =>
                        //     context.read<DashboardCubit>().toggleVideoPlay(),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            // isPlaying ? Icons.pause : Icons.play_arrow,
                            Icons.play_arrow,
                            size: 32,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'duration',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'views views',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        // onTap: () => context.read<DashboardCubit>().likeVideo(),
                        child: Row(
                          children: [
                            Icon(Icons.favorite,
                                size: 16, color: Colors.red[400]),
                            const SizedBox(width: 4),
                            Text(
                              'likes likes',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ...['platforms'].map((platform) => Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: platform == 'YouTube'
                                  ? Colors.red
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              platform,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
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

  Widget _buildRecordNewGameCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.videocam, color: Colors.blue[600], size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Record New Game',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Capture your best moments and create highlights',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            // onTap: () => context.read<DashboardCubit>().navigateToRecordGame(),
            child: Icon(Icons.chevron_right, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              GestureDetector(
                // onTap: () => context.read<DashboardCubit>().viewAllActivities(),
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // ...recentActivities
        //     .map((activity) => _buildActivityItem(context, activity)),
      ],
    );
  }

  Widget _buildActivityItem(BuildContext context) {
    IconData iconData;
    Color iconColor;

    // switch (activity.iconType) {
    //   case 'soccer':
    //     iconData = Icons.sports_soccer;
    //     iconColor = Colors.green;
    //     break;
    //   case 'tennis':
    //     iconData = Icons.sports_tennis;
    //     iconColor = Colors.blue;
    //     break;
    //   default:
    //     iconData = Icons.sports;
    //     iconColor = Colors.grey;
    // }

    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
      child: GestureDetector(
        // onTap: () =>
        //     context.read<DashboardCubit>().onActivityItemTapped(activity.id),
        child: Row(
          children: [
            // Container(
            //   width: 44,
            //   height: 44,
            //   decoration: BoxDecoration(
            //     // color: iconColor.withOpacity(0.1),
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(iconData, color: iconColor, size: 20),
            // ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'status',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'timeAgo',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
