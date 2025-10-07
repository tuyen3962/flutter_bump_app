import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/campaign_details/campaign_details_cubit.dart';
import 'package:flutter_bump_app/screen/campaign_details/campaign_details_parameter.dart';

import 'campaign_details_state.dart';

@RoutePage()
class CampaignDetailsPage
    extends BaseBlocProvider<CampaignDetailsState, CampaignDetailsCubit> {
  const CampaignDetailsPage({super.key, required this.parameter});

  final CampaignDetailsParameter parameter;

  @override
  Widget buildPage() {
    return const CampaignDetailsScreen();
  }

  @override
  CampaignDetailsCubit createCubit() {
    return CampaignDetailsCubit(parameter: parameter);
  }
}

class CampaignDetailsScreen extends StatefulWidget {
  const CampaignDetailsScreen({super.key});

  @override
  State<CampaignDetailsScreen> createState() => CampaignDetailsScreenState();
}

class CampaignDetailsScreenState extends BaseBlocNoAppBarPageState<
    CampaignDetailsScreen, CampaignDetailsState, CampaignDetailsCubit> {
  int? expandedVideoIndex;

  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, CampaignDetailsCubit cubit) {
    return BlocBuilder<CampaignDetailsCubit, CampaignDetailsState>(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildOverviewCard(state),
                        SizedBox(height: 16.h),
                        _buildChannelInfoCard(state),
                        SizedBox(height: 16.h),
                        _buildPerformanceCard(state),
                        SizedBox(height: 16.h),
                        _buildVideosCard(state),
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
      padding: padding(horizontal: 16.w, vertical: 16.h),
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
            'Campaign Details',
            style: AppStyle.bold20(color: appTheme.whiteText),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(CampaignDetailsState state) {
    return Container(
      padding: padding(all: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.gps_fixed,
                color: appTheme.green4AColor,
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Overview',
                style: AppStyle.bold16(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildInfoRow('Creator', state.creatorName, showIcons: true),
          SizedBox(height: 12.h),
          _buildInfoRow(
            'Status',
            state.status,
            statusBadge: true,
            showEdit: state.status == 'in_progress',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow('Duration', state.duration),
          SizedBox(height: 12.h),
          _buildInfoRow(
            'Budget Spent',
            '${state.budget.toStringAsFixed(1)} SOL',
            valueColor: appTheme.green4AColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    bool showIcons = false,
    bool statusBadge = false,
    bool showEdit = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyle.regular14(color: Colors.white60),
        ),
        if (statusBadge)
          Row(
            children: [
              Container(
                padding: padding(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: value == 'Completed'
                      ? const Color(0xFF22C55E).withSafeOpacity(0.2)
                      : const Color(0xFFEAB308).withSafeOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: value == 'Completed'
                        ? const Color(0xFF22C55E).withSafeOpacity(0.3)
                        : const Color(0xFFEAB308).withSafeOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  value,
                  style: AppStyle.regular12(
                    color: value == 'Completed'
                        ? const Color(0xFF22C55E)
                        : const Color(0xFFEAB308),
                  ),
                ),
              ),
              if (showEdit) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    // TODO: Edit campaign
                  },
                  child: Container(
                    padding: padding(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF374151),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Edit',
                      style: AppStyle.regular10(color: appTheme.whiteText),
                    ),
                  ),
                ),
              ],
            ],
          )
        else
          Row(
            children: [
              if (showIcons) ...[
                Icon(Icons.play_circle, color: Colors.red, size: 14.w),
                SizedBox(width: 4.w),
                Icon(Icons.music_note, color: Colors.white70, size: 14.w),
                SizedBox(width: 8.w),
              ],
              Text(
                value,
                style: AppStyle.bold14(
                  color: valueColor ?? appTheme.whiteText,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildChannelInfoCard(CampaignDetailsState state) {
    return Container(
      padding: padding(all: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.message,
                color: appTheme.green4AColor,
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Channel Information',
                style: AppStyle.bold16(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Brand Assets
          Row(
            children: [
              Expanded(
                child: _buildAssetBox('Logo', '🏢'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildAssetBox('Banner', null),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Social Links
          Text(
            'Social Links',
            style: AppStyle.medium12(color: Colors.white60),
          ),
          SizedBox(height: 8.h),
          ...state.socialLinks.entries.map((entry) {
            return Container(
              margin: padding(bottom: 8.h),
              padding: padding(all: 8.w),
              decoration: BoxDecoration(
                color: Colors.white.withSafeOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _getSocialIcon(entry.key),
                    color: _getSocialColor(entry.key),
                    size: 14.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${entry.key.capitalize()}:',
                    style: AppStyle.medium12(color: appTheme.whiteText),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: AppStyle.regular12(
                        color: _getSocialColor(entry.key),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAssetBox(String label, String? emoji) {
    return Container(
      padding: padding(all: 12.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: appTheme.green4AColor.withSafeOpacity(0.2),
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
        color: appTheme.green4AColor.withSafeOpacity(0.05),
      ),
      child: Column(
        children: [
          if (emoji != null)
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: appTheme.green4AColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 16)),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 24.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appTheme.green4AColor, appTheme.green69Color],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppStyle.medium10(color: appTheme.whiteText),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(CampaignDetailsState state) {
    return Container(
      padding: padding(all: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: const Color(0xFF22C55E),
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Performance Metrics',
                style: AppStyle.bold16(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildMetricRow('Total Views', '267K', const Color(0xFF22C55E)),
          SizedBox(height: 12.h),
          _buildMetricRow('Likes', '12.8K', appTheme.whiteText),
          SizedBox(height: 12.h),
          _buildMetricRow('Shares', '3.2K', appTheme.whiteText),
          SizedBox(height: 12.h),
          _buildMetricRow('Comments', '892', appTheme.whiteText),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyle.regular14(color: Colors.white60),
        ),
        Text(
          value,
          style: AppStyle.bold14(color: valueColor),
        ),
      ],
    );
  }

  Widget _buildVideosCard(CampaignDetailsState state) {
    return Container(
      padding: padding(all: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.video_library,
                color: appTheme.green4AColor,
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Videos',
                style: AppStyle.bold16(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...state.videos.asMap().entries.map((entry) {
            final index = entry.key;
            final video = entry.value;
            return _buildVideoCard(video, index);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildVideoCard(Map<String, dynamic> video, int index) {
    final isExpanded = expandedVideoIndex == index;

    return Container(
      margin: padding(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withSafeOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expandedVideoIndex = isExpanded ? null : index;
              });
            },
            child: Container(
              padding: padding(all: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          video['title'],
                          style: AppStyle.bold16(color: appTheme.whiteText),
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: appTheme.whiteText,
                        size: 24.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Stats row
                  Row(
                    children: [
                      Text(
                        '${video['views']} views',
                        style: AppStyle.regular12(color: Colors.white60),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        video['date'],
                        style: AppStyle.regular12(color: Colors.white60),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Requirements & badge row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF22C55E),
                            size: 14.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '${video['requirementsMet']}/${video['totalRequirements']} requirements',
                            style: AppStyle.regular12(color: Colors.white60),
                          ),
                        ],
                      ),
                      Container(
                        padding: padding(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E).withSafeOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF22C55E).withSafeOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Verified',
                          style: AppStyle.medium12(
                            color: const Color(0xFF22C55E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) _buildExpandedVideoContent(video),
        ],
      ),
    );
  }

  Widget _buildExpandedVideoContent(Map<String, dynamic> video) {
    return Container(
      padding: padding(all: 12.w),
      decoration: BoxDecoration(
        color: Colors.white.withSafeOpacity(0.03),
        border: Border(
          top: BorderSide(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Platform buttons
          Row(
            children: [
              SizedBox(
                height: 32.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Open YouTube
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF0000),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: padding(horizontal: 12.w),
                  ),
                  child: Icon(
                    Icons.play_circle,
                    color: appTheme.whiteText,
                    size: 14.w,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                height: 32.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Open TikTok
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF000000),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: padding(horizontal: 12.w),
                  ),
                  child: Icon(
                    Icons.music_note,
                    color: appTheme.whiteText,
                    size: 14.w,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                height: 32.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Download
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF374151),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: padding(horizontal: 12.w),
                  ),
                  child: Icon(
                    Icons.download,
                    color: appTheme.whiteText,
                    size: 14.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Requirements verification
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: const Color(0xFF22C55E),
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Requirements Verification',
                style: AppStyle.medium12(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...(video['requirements'] as List<Map<String, dynamic>>).map((req) {
            return Container(
              margin: padding(bottom: 6.h),
              padding: padding(all: 8.w),
              decoration: BoxDecoration(
                color: Colors.white.withSafeOpacity(0.05),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(
                    req['completed']
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: req['completed']
                        ? const Color(0xFF22C55E)
                        : Colors.white38,
                    size: 14.w,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      req['label'],
                      style: AppStyle.regular12(
                        color: req['completed']
                            ? appTheme.whiteText
                            : Colors.white60,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'website':
        return Icons.language;
      case 'twitter':
        return Icons.tag;
      case 'telegram':
        return Icons.send;
      case 'discord':
        return Icons.chat;
      default:
        return Icons.link;
    }
  }

  Color _getSocialColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'website':
        return appTheme.green4AColor;
      case 'twitter':
        return const Color(0xFF1DA1F2);
      case 'telegram':
        return const Color(0xFF0088CC);
      case 'discord':
        return const Color(0xFF5865F2);
      default:
        return appTheme.green4AColor;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
