// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class SigninState extends BaseState {
  final String? errorMessage;
  final bool? isSuccess;

  const SigninState({
    this.errorMessage,
    super.isLoading = false,
    this.isSuccess = false,
  });

  SigninState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return SigninState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
