import 'package:auto_route/auto_route.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';

import 'dashboard_state.dart';

class DashboardCubit extends BaseCubit<DashboardState> {
  late final AccountService accountService = locator.get();

  DashboardCubit() : super(DashboardState());

  late TabsRouter tabRouter;

  void onChangeTab(int tab) {
    if (tab == 4) {
      navigatorKey.currentContext!.pushRoute(const CreateHighlightRoute());
      return;
    }
    tabRouter.setActiveIndex(tab);
    emit(state.copyWith(currentIndex: tab));
  }
}
