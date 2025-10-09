import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/campaign_details/campaign_details_parameter.dart';

class MyCampaignView extends StatelessWidget {
  const MyCampaignView({super.key, this.campaign});

  final CampaignModel? campaign;

  String get duration {
    if (campaign?.startDate == null || campaign?.endDate == null) {
      return '';
    }
    return '${campaign?.startDate} → ${campaign?.endDate}';
  }

  @override
  Widget build(BuildContext context) {
    final socialLinkTypes = campaign?.socialLinkTypes ?? [];
    final isCompleted = campaign?.status == CampaignStatus.COMPLETED;
    return Container(
      margin: padding(bottom: 16.h),
      padding: padding(all: 16.w),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    campaign?.creator?.name ?? '',
                    style: AppStyle.bold16(color: appTheme.whiteText),
                  ),
                  SizedBox(width: 8.w),
                  if (socialLinkTypes.contains(SocialLinkType.YOUTUBE))
                    Icon(Icons.play_circle, color: Colors.red, size: 14.w),
                  if (socialLinkTypes.contains(SocialLinkType.TIKTOK))
                    Icon(Icons.music_note, color: Colors.white70, size: 14.w),
                ],
              ),
              Container(
                padding: padding(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF22C55E).withSafeOpacity(0.2)
                      : const Color(0xFFEAB308).withSafeOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF22C55E).withSafeOpacity(0.3)
                        : const Color(0xFFEAB308).withSafeOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  isCompleted ? 'Completed' : 'In Progress',
                  style: AppStyle.regular10(
                    color: isCompleted
                        ? const Color(0xFF22C55E)
                        : const Color(0xFFEAB308),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Budget',
                style: AppStyle.regular12(color: Colors.white60),
              ),
              Text(
                '${campaign?.budget} SOL',
                style: AppStyle.bold14(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duration',
                style: AppStyle.regular12(color: Colors.white60),
              ),
              Text(
                duration,
                style: AppStyle.bold14(color: appTheme.whiteText),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 36.h,
            child: ElevatedButton(
              onPressed: () => campaign != null
                  ? context.pushRoute(CampaignDetailsRoute(
                      parameter: CampaignDetailsParameter(campaign: campaign!),
                    ))
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF374151),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'View Details',
                style: AppStyle.medium12(color: appTheme.whiteText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
