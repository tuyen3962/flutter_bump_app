import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/stream/base_stream_builder.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/service/language_service.dart';
import 'package:flutter_bump_app/config/theme/app_theme_util.dart';
import 'package:flutter_bump_app/config/theme/base_theme_data.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/utils/reponsive/size_config.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'bootstrap.dart';

AppThemeUtil themeUtil = AppThemeUtil();
BaseThemeData get appTheme => themeUtil.getAppTheme();

/// Router
final appRouter = AppRouter();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
GlobalKey<NavigatorState> get navigatorKey => appRouter.navigatorKey;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();
  await configureDependencies();
  bootstrap(() {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.instance.init(
            constraints: constraints, screenHeight: 812, screenWidth: 375);

        return EasyLocalization(
          supportedLocales: supportedLocales,
          path: 'assets/lang',
          fallbackLocale: english,
          startLocale: english,
          child: const MainAppPage(),
        );
      },
    );
  });
}

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  static MainAppPageState of(BuildContext context) {
    final state = context.findAncestorStateOfType<MainAppPageState>();

    if (state == null) {
      throw Exception('The state still not init');
    }

    return state;
  }

  @override
  State<MainAppPage> createState() => MainAppPageState();
}

class MainAppPageState extends State<MainAppPage> {
  final languageService = locator.get<LanguageService>();

  void onSwitchLightDarkMode() {
    themeUtil.onChangeLightDarkMode();
  }

  @override
  void dispose() {
    themeUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TwoBaseStreamBuilder(
      firstController: languageService.language,
      secondController: SizeConfig.instance.isLandscape,
      builder: (language, landscape) => ValueListenableBuilder(
        valueListenable: themeUtil.themeType,
        builder: (context, type, child) {
          return MaterialApp.router(
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: themeUtil.theme.getThemeData(type),
            routerConfig: appRouter.config(
                navigatorObservers: () => [
                      routeObserver,
                      ...AutoRouterDelegate.defaultNavigatorObserversBuilder()
                    ]),
            builder: EasyLoading.init(
              builder: (context, child) => child!,
            ),
          );
        },
      ),
    );
  }
}
