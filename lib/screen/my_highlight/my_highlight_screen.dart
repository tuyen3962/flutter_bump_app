import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/screen/my_highlight/my_highlight_cubit.dart';

import 'my_highlight_state.dart';

@RoutePage()
class MyHighlightPage
    extends BaseBlocProvider<MyHighlightState, MyHighlightCubit> {
  const MyHighlightPage({super.key});

  @override
  Widget buildPage() {
    return const MyHighlightScreen();
  }

  @override
  MyHighlightCubit createCubit() {
    return MyHighlightCubit();
  }
}

class MyHighlightScreen extends StatefulWidget {
  const MyHighlightScreen({super.key});

  @override
  State<MyHighlightScreen> createState() => MyHighlightScreenState();
}

class MyHighlightScreenState extends BaseBlocPageState<MyHighlightScreen,
    MyHighlightState, MyHighlightCubit> {
  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  String get title => 'My Highlights';

  @override
  Widget buildBody(BuildContext context, MyHighlightCubit cubit) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: Column(
        children: [
          _buildStatsSection(context, cubit.state),
          _buildFilterTabs(context, cubit.state),
          Expanded(
            child: _buildHighlightsList(context, cubit.state),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, MyHighlightState state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            '${state.totalHighlights}',
            'Highlights',
          ),
          _buildStatItem(
            '${_formatNumber(state.totalViews)}',
            'Total Views',
          ),
          _buildStatItem(
            '${state.totalLikes}',
            'Total Likes',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}K';
    }
    return number.toString();
  }

  Widget _buildFilterTabs(BuildContext context, MyHighlightState state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          _buildFilterTab(
            context,
            'All',
            HighlightFilter.all,
            state.currentFilter == HighlightFilter.all,
          ),
          const SizedBox(width: 12),
          _buildFilterTab(
            context,
            'Posted',
            HighlightFilter.posted,
            state.currentFilter == HighlightFilter.posted,
          ),
          const SizedBox(width: 12),
          _buildFilterTab(
            context,
            'Not Posted',
            HighlightFilter.notPosted,
            state.currentFilter == HighlightFilter.notPosted,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(
    BuildContext context,
    String label,
    HighlightFilter filter,
    bool isSelected,
  ) {
    return GestureDetector(
      // onTap: () => context.read<MyHighlightsCubit>().applyFilter(filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[600] : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightsList(BuildContext context, MyHighlightState state) {
    if (false) {
      // emepty list
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library_outlined,
                size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No highlights found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first highlight to get started!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 10,
      itemBuilder: (context, index) {
        // final highlight = state.filteredHighlights[index];
        // final isPlaying = state is MyHighlightsVideoPlaying &&
        //     state.playingVideoId == highlight.id;

        return _buildHighlightCard(context, false);
      },
    );
  }

  Widget _buildHighlightCard(
    BuildContext context,
    // HighlightVideo highlight,
    bool isPlaying,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'title',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'timeAgo',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (false)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Posted',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.grey[300],
                  //   image: DecorationImage(
                  //     image: NetworkImage(highlight.thumbnailUrl),
                  //     fit: BoxFit.cover,
                  //     onError: (_, __) {},
                  //   ),
                  // ),
                  child: Center(
                    child: GestureDetector(
                      // onTap: () => context
                      //     .read<MyHighlightsCubit>()
                      //     .toggleVideoPlay(highlight.id),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.remove_red_eye,
                        size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      // '${_formatNumber(views)}',
                      'views',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  // onTap: () =>
                  //     context.read<MyHighlightsCubit>().likeVideo(highlight.id),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, size: 16, color: Colors.red[400]),
                      const SizedBox(width: 4),
                      Text(
                        'likes',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
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
                        color:
                            platform == 'YouTube' ? Colors.red : Colors.black,
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
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                  onSelected: (value) {
                    switch (value) {
                      case 'share':
                        // context
                        //     .read<MyHighlightsCubit>()
                        //     .shareHighlight(highlight.id);
                        break;
                      case 'edit':
                        // context
                        //     .read<MyHighlightsCubit>()
                        //     .editHighlight(highlight.id);
                        break;
                      case 'delete':
                        // _showDeleteConfirmation(context, highlight.id);
                        break;
                      case 'post':
                        // _showPostDialog(context, highlight.id);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'share',
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(width: 8),
                          Text('Share'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    // if (!highlight.isPosted)
                    const PopupMenuItem(
                      value: 'post',
                      child: Row(
                        children: [
                          Icon(Icons.upload),
                          SizedBox(width: 8),
                          Text('Post'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String videoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Highlight'),
        content: const Text(
            'Are you sure you want to delete this highlight? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // context.read<MyHighlightsCubit>().deleteHighlight(videoId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showPostDialog(BuildContext context, String videoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Post Highlight'),
        content: const Text('Select platforms to post your highlight:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // context
              //     .read<MyHighlightsCubit>()
              //     .postHighlight(videoId, ['YouTube', 'TikTok']);
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}
