import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/screen/campaign_details/campaign_details_parameter.dart';
import 'package:flutter_bump_app/screen/campaign_details/campaign_details_screen.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_screen.dart';
import 'package:flutter_bump_app/screen/discover_detail/discover_detail_parameter.dart';
import 'package:flutter_bump_app/screen/discover_detail/discover_detail_screen.dart';
import 'package:flutter_bump_app/screen/home/home_screen.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/launch_sponsorship_parameter.dart';
import 'package:flutter_bump_app/screen/launch_sponsorship/launch_sponsorship_screen.dart';
import 'package:flutter_bump_app/screen/profile/profile_screen.dart';
import 'package:flutter_bump_app/screen/sign_in/sign_in_screen.dart';
import 'package:flutter_bump_app/screen/splash/splash_screen.dart';
import 'package:flutter_bump_app/screen/sponsor_hub/sponsor_hub_screen.dart';
import 'package:flutter_bump_app/screen/update_profile/update_profile_screen.dart';
import 'package:flutter_bump_app/screen/wallet/wallet_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page),
        // AutoRoute(
        //   page: DashboardRoute.page,
        //   // children: [
        //   //   AutoRoute(page: HomeRoute.page, initial: true),
        //   // ],
        // ),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: UpdateProfileRoute.page),
        AutoRoute(page: CreateHighlightRoute.page),
        AutoRoute(page: SponsorHubRoute.page),
        AutoRoute(page: DiscoverDetailRoute.page),
        AutoRoute(page: WalletRoute.page),
        AutoRoute(page: CampaignDetailsRoute.page),
        AutoRoute(page: LaunchSponsorshipRoute.page),
      ];
}
