import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  BaseCubit(super.initialState);

  bool isClose = false;

  void onInit() {}

  void onReady() {}

  @override
  Future<void> close() async {
    isClose = true;
    super.close();
  }

  @override
  void emit(S state) {
    if (isClose) return;
    super.emit(state);
  }
}
