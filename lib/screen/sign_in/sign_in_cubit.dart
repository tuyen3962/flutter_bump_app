// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/auth_service.dart';
import 'package:flutter_bump_app/screen/sign_in/sign_in_state.dart';
import 'package:flutter_bump_app/utils/loading.dart';

class SignInCubit extends BaseCubit<SignInState> {
  final AuthService authService;

  SignInCubit({required this.authService}) : super(const SignInState());

  Future<void> signInWithGoogle() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final result = await authService.signInWithGoogle();
      if (result) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          isSuccess: true,
        ));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: 'Đã xảy ra lỗi'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
    dismissLoading();
  }
}
