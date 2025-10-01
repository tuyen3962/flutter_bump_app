import 'package:auto_route/auto_route.dart';
import 'package:flutter_bump_app/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_bump_app/screen/home/home_screen.dart';
import 'package:flutter_bump_app/screen/profile/profile_screen.dart';
import 'package:flutter_bump_app/screen/sign_in/sign_in_screen.dart';
import 'package:flutter_bump_app/screen/splash/splash_screen.dart';
import 'package:flutter_bump_app/screen/update_profile/update_profile_screen.dart';

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
      ];
}
