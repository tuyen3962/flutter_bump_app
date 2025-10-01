import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/splash/splash_cubit.dart';

import 'splash_state.dart';

@RoutePage()
class SplashPage extends BaseBlocProvider<SplashState, SplashCubit> {
  const SplashPage({super.key});

  @override
  Widget buildPage() {
    return const SplashScreen();
  }

  @override
  SplashCubit createCubit() {
    return SplashCubit(
      accountService: locator.get(),
      localStorage: locator.get(),
      accountRepository: locator.get(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState
    extends BaseBlocNoAppBarPageState<SplashScreen, SplashState, SplashCubit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeSplash();
    });
  }

  @override
  String get title => 'Splash';

  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, SplashCubit cubit) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (cubit.accountService.isLoggedIn) {
          context.replaceRoute(const HomeRoute());
        } else {
          context.replaceRoute(const SignInRoute());
        }
      },
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Text(
            'Welcome to Bump App',
            style: AppStyle.regular16(color: appTheme.green800),
          );
        },
      ),
    );
  }
}
