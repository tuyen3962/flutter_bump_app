import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'my_highlight_state.dart';

class MyHighlightCubit extends BaseCubit<MyHighlightState> {
  late final AccountService accountService = locator.get();

  MyHighlightCubit() : super(MyHighlightState());

  @override
  void onInit() {
    super.onInit();
    // Add your initialization logic here
  }

  @override
  void onReady() {
    super.onReady();
    // Add your ready logic here
  }

  // Add your business logic methods here
  void doSomething() {
    // Example method
    emit(state.copyWith(isLoading: true));
    
    // Simulate async operation
    Future.delayed(const Duration(seconds: 1), () {
      if (!isClose) {
        emit(state.copyWith(isLoading: false));
      }
    });
  }
}
