import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  late final AccountService accountService = locator.get();
  final isScale = ValueNotifier<bool>(false);

  SplashCubit() : super(SplashState());
}
