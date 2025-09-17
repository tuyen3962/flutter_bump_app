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
import 'package:flutter_bump_app/screen/highlight_player/highlight_player_cubit.dart';
import 'package:flutter_bump_app/screen/highlight_player/highlight_player_state.dart';
import 'package:flutter_bump_app/screen/upload_to_platform/upload_to_platform_parameter.dart';

@RoutePage()
class HighlightPlayerPage extends BaseBlocProvider<HighlightPlayerState, HighlightPlayerCubit> {
  const HighlightPlayerPage({super.key});

  @override
  Widget buildPage() {
    return const HighlightPlayerScreen();
  }

  @override
  HighlightPlayerCubit createCubit() {
    return HighlightPlayerCubit();
  }
}

class HighlightPlayerScreen extends StatefulWidget {
  const HighlightPlayerScreen({super.key});

  @override
  State<HighlightPlayerScreen> createState() => HighlightPlayerScreenState();
}

class HighlightPlayerScreenState
    extends BaseBlocNoAppBarPageState<HighlightPlayerScreen, HighlightPlayerState, HighlightPlayerCubit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializePlayer();
    });
  }

  @override
  String get title => 'Highlight Player';

  @override
  Widget buildBody(BuildContext context, HighlightPlayerCubit cubit) {
    return BlocBuilder<HighlightPlayerCubit, HighlightPlayerState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.gray50,
          body: Column(
            children: [
              // Header
              _buildHeader(),

              // Video Player
              _buildVideoPlayer(state),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: padding(all: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Video Info
                      _buildVideoInfo(state),

                      SizedBox(height: 24.h),

                      // Stats and Actions
                      _buildStatsAndActions(state),

                      SizedBox(height: 24.h),

                      // Share Options
                      _buildShareOptions(state),

                      SizedBox(height: 24.h),

                      // Recent Highlights
                      _buildRecentHighlights(state),
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
              onTap: () => context.back(),
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
                'Highlight Player',
                style: AppStyle.bold18(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 32.w),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(HighlightPlayerState state) {
    return Container(
      width: double.infinity,
      height: 192.h,
      color: appTheme.gray900,
      child: Stack(
        children: [
          // Play button
          Center(
            child: GestureDetector(
              onTap: cubit.togglePlayPause,
              child: Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: appTheme.alpha,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Icon(
                  state.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 32,
                  color: appTheme.gray900,
                ),
              ),
            ),
          ),

          // Video controls overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: padding(all: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    appTheme.blackColor.withSafeOpacity(0.5),
                    appTheme.transparentColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Progress bar
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTapDown: (details) {
                            final RenderBox box = context.findRenderObject() as RenderBox;
                            final position = details.localPosition.dx / box.size.width;
                            cubit.updatePosition(position.clamp(0.0, 1.0));
                          },
                          child: Container(
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: appTheme.alpha.withSafeOpacity(0.3),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: state.currentPosition,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appTheme.alpha,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${state.currentTime} / ${state.totalDuration}',
                        style: AppStyle.regular12(color: appTheme.alpha),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoInfo(HighlightPlayerState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.videoTitle,
          style: AppStyle.bold18(),
        ),
        SizedBox(height: 4.h),
        Text(
          state.videoDescription,
          style: AppStyle.regular14(color: appTheme.gray500),
        ),
      ],
    );
  }

  Widget _buildStatsAndActions(HighlightPlayerState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // View and Like Stats
        Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.visibility,
                  size: 20,
                  color: appTheme.gray600,
                ),
                SizedBox(width: 8.w),
                Text(
                  '${state.viewCount}',
                  style: AppStyle.medium16(color: appTheme.gray600),
                ),
              ],
            ),
            SizedBox(width: 24.w),
            GestureDetector(
              onTap: cubit.likeVideo,
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    size: 20,
                    color: appTheme.gray600,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${state.likeCount}',
                    style: AppStyle.medium16(color: appTheme.gray600),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Download button
        GestureDetector(
          onTap: () async {
            await cubit.downloadVideo();
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                      'Video downloaded successfully!',
                      style: AppStyle.medium14(color: appTheme.alpha),
                    ),
                    backgroundColor: appTheme.green500,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: padding(all: 16)),
              );
            }
          },
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: appTheme.gray100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.download,
              size: 18,
              color: appTheme.gray600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShareOptions(HighlightPlayerState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Upload & Share',
          style: AppStyle.medium16(),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            // YouTube button
            GestureDetector(
              onTap: () => context.pushRoute(
                UploadToPlatformRoute(
                  platformParam: UploadToPlatformParameter(platform: PlatformType.youtube),
                ),
              ),
              child: Container(
                padding: padding(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: appTheme.red500,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: state.isPlatformShared('youtube')
                      ? []
                      : [
                          BoxShadow(
                            color: appTheme.gray200.withSafeOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Opacity(
                  opacity: state.isPlatformShared('youtube') ? 0.5 : 1.0,
                  child: Text(
                    'YouTube',
                    style: AppStyle.medium14(color: appTheme.alpha),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // TikTok button
            GestureDetector(
              onTap: () => context.pushRoute(
                UploadToPlatformRoute(
                  platformParam: UploadToPlatformParameter(platform: PlatformType.tiktok),
                ),
              ),
              child: Container(
                padding: padding(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: appTheme.gray900,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: state.isPlatformShared('tiktok')
                      ? []
                      : [
                          BoxShadow(
                            color: appTheme.gray200.withSafeOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Opacity(
                  opacity: state.isPlatformShared('tiktok') ? 0.5 : 1.0,
                  child: Text(
                    'TikTok',
                    style: AppStyle.medium14(color: appTheme.alpha),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentHighlights(HighlightPlayerState state) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: appTheme.blue500,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Highlights',
          style: AppStyle.medium16(),
        ),
        SizedBox(height: 12.h),
        Column(
          children: state.recentHighlights.map((highlight) {
            return Container(
              margin: padding(bottom: 12.h),
              padding: padding(all: 12),
              decoration: BoxDecoration(
                color: appTheme.alpha,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: appTheme.gray200),
              ),
              child: Row(
                children: [
                  // Thumbnail
                  Container(
                    width: 64.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: appTheme.gray300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'IMG',
                        style: AppStyle.regular12(color: appTheme.gray600),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          highlight.title,
                          style: AppStyle.medium14(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${highlight.views} views',
                          style: AppStyle.regular14(color: appTheme.gray500),
                        ),
                      ],
                    ),
                  ),

                  // Play button
                  GestureDetector(
                    onTap: () => cubit.playRecentHighlight(highlight.id),
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: appTheme.gray100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        size: 16,
                        color: appTheme.gray600,
                      ),
                    ),
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
