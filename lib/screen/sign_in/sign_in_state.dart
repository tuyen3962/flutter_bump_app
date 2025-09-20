// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class SignInState extends BaseState {
  final String? errorMessage;
  final bool? isSuccess;

  const SignInState({
    this.errorMessage,
    super.isLoading = false,
    this.isSuccess = false,
  });

  SignInState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
