import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class SigninState extends BaseState {
  final User? user;
  final String? errorMessage;

  const SigninState({
    this.user,
    this.errorMessage,
    super.isLoading = false,
  });

  SigninState copyWith({
    bool? isLoading,
    User? user,
    String? errorMessage,
  }) {
    return SigninState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
