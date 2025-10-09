import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/launch_sponsorship_parameter.dart';
import 'package:flutter_bump_app/widget/image/cache_image.dart';

class SetupCampaignView extends StatelessWidget {
  const SetupCampaignView({super.key, this.campaign});

  final CampaignModel? campaign;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding(bottom: 16.h),
      padding: padding(all: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: appTheme.green4AColor.withSafeOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      appTheme.green4AColor.withSafeOpacity(0.2),
                      appTheme.green69Color.withSafeOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: CircleAvatar(
                      child: CacheImage(
                          imageUrl: campaign?.creator?.avatar ?? '',
                          size: 24.w,
                          boxFit: BoxFit.cover)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign?.creator?.name ?? '',
                      style: AppStyle.bold16(color: appTheme.whiteText),
                    ),
                    Text(
                      campaign?.creator?.expertises?.join(', ') ?? '',
                      style: AppStyle.regular12(color: Colors.white60),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Winning Bid',
                    style: AppStyle.regular10(color: appTheme.green4AColor),
                  ),
                  Text(
                    '${campaign?.budget} SOL',
                    style: AppStyle.bold14(color: appTheme.green4AColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: () => campaign == null
                  ? null
                  : context.pushRoute(LaunchSponsorshipRoute(
                      parameter:
                          LaunchSponsorshipParameter(campaign: campaign!))),
              style: ElevatedButton.styleFrom(
                backgroundColor: appTheme.transparentColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [appTheme.green4AColor, appTheme.green69Color],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.rocket_launch,
                        color: const Color(0xFF0F172A),
                        size: 16.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Setup',
                        style: AppStyle.bold14(color: const Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
