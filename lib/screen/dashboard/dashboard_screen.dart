import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/screen/dashboard/dashboard_cubit.dart';

import 'dashboard_state.dart';

@RoutePage()
class DashboardPage extends BaseBlocProvider<DashboardState, DashboardCubit> {
  const DashboardPage({super.key});

  @override
  Widget buildPage() {
    return const DashboardScreen();
  }

  @override
  DashboardCubit createCubit() {
    return DashboardCubit();
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends BaseBlocNoAppBarPageState<DashboardScreen,
    DashboardState, DashboardCubit> {
  @override
  String get title => 'Dashboard';

  @override
  Widget buildBody(BuildContext context, DashboardCubit cubit) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Dashboard Screen',
            style: AppStyle.bold24(),
          ),
          const SizedBox(height: 16),
          Text(
            'This is the dashboard screen',
            style: AppStyle.regular16(),
          ),
        ],
      ),
    );
  }
}
