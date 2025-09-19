import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
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
  bool? get isBottomSafeArea => false;

  @override
  Widget buildBody(BuildContext context, DashboardCubit cubit) {
    return AutoTabsScaffold(
      extendBody: true,
      routes: [
        HomeRoute(),
        HighlightsRoute(),
        ActivityRoute(),
        ProfileRoute(),
      ],
      floatingActionButton: Container(
        padding: padding(all: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0x26000000), blurRadius: 24, offset: Offset(0, 3)),
          ],
        ),
        child: InkWell(
          onTap: () => cubit.onChangeTab(4),
          borderRadius: BorderRadius.circular(1000),
          child: Container(
            padding: padding(all: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appTheme.appColor,
            ),
            child: Icon(Icons.add, size: 32, color: appTheme.whiteText),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBuilder: (context, tabsRouter) {
        cubit.tabRouter = tabsRouter;

        return Container(
          decoration: BoxDecoration(
            color: appTheme.transparentColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 24,
                  offset: Offset(0, 4)),
            ],
          ),
          child: AnimatedBottomNavigationBar.builder(
            itemCount: 4,
            tabBuilder: (int index, bool isActive) {
              Icon icon;
              String label;
              switch (index) {
                case 0:
                  icon = cubit.state.currentIndex == 0
                      ? Icon(Icons.home_filled)
                      : Icon(Icons.home_outlined);
                  label = 'Home';
                  break;
                case 1:
                  icon = cubit.state.currentIndex == 1
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border);
                  label = 'Highlights';
                  break;
                case 2:
                  icon = cubit.state.currentIndex == 2
                      ? Icon(Icons.local_post_office)
                      : Icon(Icons.mail_outline);
                  label = 'Activity';
                  break;
                case 3:
                  icon = cubit.state.currentIndex == 3
                      ? Icon(Icons.person)
                      : Icon(Icons.person_outline);
                  label = 'Profile';
                  break;
                default:
                  icon = Icon(Icons.home_outlined);
                  label = '';
              }
              return _buildNavItem(
                icon: icon,
                label: label,
                isActive: isActive,
              );
            },
            activeIndex: cubit.state.currentIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: cubit.onChangeTab,
            notchMargin: 0.1,
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      {required Widget icon, required String label, required bool isActive}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(height: 6.h),
        Text(
          label,
          style: isActive
              ? AppStyle.medium10(color: appTheme.appColor)
              : AppStyle.regular10(color: appTheme.gray600),
        ),
      ],
    );
  }
}
