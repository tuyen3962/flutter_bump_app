import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
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
    return SplashCubit();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState
    extends BaseBlocPageState<SplashScreen, SplashState, SplashCubit> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => context.replaceRoute(const DashboardRoute()));
    super.initState();
  }

  @override
  Widget buildView(BuildContext context, SplashCubit cubit) {
    return Center(
      child: Text('Pickle clipper', style: AppStyle.bold28()),
    );
  }
}
