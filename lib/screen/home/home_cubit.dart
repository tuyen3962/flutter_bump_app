import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  late final AccountService accountService = locator.get();

  HomeCubit() : super(const HomeState());
}
