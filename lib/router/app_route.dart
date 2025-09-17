import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/screen/activity/activity_screen.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_screen.dart';
import 'package:flutter_bump_app/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_bump_app/screen/highlight_player/highlight_player_screen.dart';
import 'package:flutter_bump_app/screen/highlights/highlights_screen.dart';
import 'package:flutter_bump_app/screen/home/home_screen.dart';
import 'package:flutter_bump_app/screen/profile/profile_screen.dart';
import 'package:flutter_bump_app/screen/settings/settings_screen.dart';
import 'package:flutter_bump_app/screen/signin/signin_screen.dart';
import 'package:flutter_bump_app/screen/splash/splash_screen.dart';
import 'package:flutter_bump_app/screen/subscription/subscription_screen.dart';
import 'package:flutter_bump_app/screen/update_profile/update_profile_screen.dart';
import 'package:flutter_bump_app/screen/upload_to_platform/upload_to_platform_parameter.dart';
import 'package:flutter_bump_app/screen/upload_to_platform/upload_to_platform_screen.dart';
import 'package:flutter_bump_app/screen/view_all_activity/view_all_activity_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SigninRoute.page),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: HighlightsRoute.page),
            AutoRoute(page: ActivityRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: UpdateProfileRoute.page),
        AutoRoute(page: CreateHighlightRoute.page),
        AutoRoute(page: HighlightPlayerRoute.page),
        AutoRoute(page: UploadToPlatformRoute.page),
        AutoRoute(page: ViewAllActivityRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: SubscriptionRoute.page),
      ];
}
