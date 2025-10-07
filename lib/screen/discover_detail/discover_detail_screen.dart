import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/discover_detail/discover_detail_cubit.dart';
import 'package:flutter_bump_app/screen/discover_detail/discover_detail_parameter.dart';

import 'discover_detail_state.dart';

@RoutePage()
class DiscoverDetailPage
    extends BaseBlocProvider<DiscoverDetailState, DiscoverDetailCubit> {
  const DiscoverDetailPage({super.key, required this.parameter});

  final DiscoverDetailParameter parameter;

  @override
  Widget buildPage() {
    return DiscoverDetailScreen(parameter: parameter);
  }

  @override
  DiscoverDetailCubit createCubit() {
    return DiscoverDetailCubit(parameter: parameter);
  }
}

class DiscoverDetailScreen extends StatefulWidget {
  const DiscoverDetailScreen({super.key, required this.parameter});

  final DiscoverDetailParameter parameter;

  @override
  State<DiscoverDetailScreen> createState() => DiscoverDetailScreenState();
}

class DiscoverDetailScreenState extends BaseBlocNoAppBarPageState<
    DiscoverDetailScreen, DiscoverDetailState, DiscoverDetailCubit> {
  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, DiscoverDetailCubit cubit) {
    return BlocBuilder<DiscoverDetailCubit, DiscoverDetailState>(
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
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: padding(all: 16.w),
                    child: Column(
                      children: [
                        _buildProfileCard(state),
                        SizedBox(height: 16.h),
                        _buildTokenPerformanceCard(state),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: padding(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.back(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white.withSafeOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: appTheme.whiteText,
                size: 20.w,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            widget.parameter.creator['name'] ?? '',
            style: AppStyle.bold20(color: appTheme.whiteText),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(DiscoverDetailState state) {
    return Container(
      padding: padding(all: 24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  appTheme.green4AColor.withSafeOpacity(0.3),
                  appTheme.green69Color.withSafeOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                widget.parameter.creator['avatar'] ?? '👤',
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Name
          Text(
            widget.parameter.creator['name'] ?? '',
            style: AppStyle.bold20(color: appTheme.whiteText),
          ),
          SizedBox(height: 8.h),

          // Topics
          Text(
            widget.parameter.creator['topics'] ?? '',
            style: AppStyle.regular14(color: Colors.white60),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),

          // Description
          Text(
            state.description,
            style: AppStyle.regular12(color: Colors.white60),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),

          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                '${widget.parameter.creator['followers']}K',
                'Followers',
                appTheme.green4AColor,
              ),
              _buildStatItem(
                '${widget.parameter.creator['rating']}',
                'Rating',
                const Color(0xFF22C55E),
              ),
              _buildStatItem(
                '${widget.parameter.creator['sponsorships']}',
                'Sponsorships',
                appTheme.green4AColor,
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Social Links
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Open YouTube
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0000),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle,
                          color: appTheme.whiteText,
                          size: 16.w,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'YouTube',
                          style: AppStyle.medium12(color: appTheme.whiteText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SizedBox(
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Open TikTok
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF000000),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.music_note,
                          color: appTheme.whiteText,
                          size: 16.w,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'TikTok',
                          style: AppStyle.medium12(color: appTheme.whiteText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
          style: AppStyle.bold20(color: color),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppStyle.regular12(color: Colors.white60),
        ),
      ],
    );
  }

  Widget _buildTokenPerformanceCard(DiscoverDetailState state) {
    return Container(
      padding: padding(all: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: const Color(0xFF22C55E),
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Creator Token Performance',
                style: AppStyle.bold16(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Token Contract
          GestureDetector(
            onTap: () {
              // TODO: Open DEXScreener
            },
            child: Container(
              width: double.infinity,
              padding: padding(all: 12.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    appTheme.green4AColor.withSafeOpacity(0.1),
                    appTheme.green69Color.withSafeOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: appTheme.green4AColor.withSafeOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Creator Token Contract',
                    style: AppStyle.regular12(color: Colors.white60),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    state.tokenContract,
                    style: AppStyle.bold14(color: appTheme.whiteText),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Stats Grid
          Row(
            children: [
              Expanded(
                child: _buildTokenStatCard(
                  'Price',
                  '\$${state.tokenPrice}',
                  appTheme.green4AColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTokenStatCard(
                  '24h Volume',
                  '\$${state.volume24h}',
                  const Color(0xFF22C55E),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildTokenStatCard(
                  'Market Cap',
                  '\$${state.marketCap}',
                  appTheme.green4AColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTokenStatCard(
                  'Holders',
                  state.holders,
                  const Color(0xFF22C55E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTokenStatCard(String label, String value, Color color) {
    return Container(
      padding: padding(all: 12.w),
      decoration: BoxDecoration(
        color: color.withSafeOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppStyle.regular12(color: Colors.white60),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: AppStyle.bold14(color: color),
          ),
        ],
      ),
    );
  }
}
