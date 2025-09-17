import 'package:auto_route/auto_route.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_screen.dart';
import 'package:flutter_bump_app/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_bump_app/screen/my_highlight/my_highlight_screen.dart';
import 'package:flutter_bump_app/screen/recent_activity/recent_activity_screen.dart';
import 'package:flutter_bump_app/screen/signin/signin_screen.dart';
import 'package:flutter_bump_app/screen/splash/splash_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SigninRoute.page),
        AutoRoute(page: CreateHighlightRoute.page),
        AutoRoute(page: DashboardRoute.page),
        AutoRoute(page: MyHighlightRoute.page),
        AutoRoute(page: RecentActivityRoute.page),
      ];
}
