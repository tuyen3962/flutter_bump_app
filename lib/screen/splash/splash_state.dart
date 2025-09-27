import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum SplashStatus { loading, checkingAuth, navigating, error }

class SplashState extends BaseState {
  final SplashStatus status;
  final bool isLoggedIn;

  const SplashState({
    this.status = SplashStatus.loading,
    this.isLoggedIn = false,
  });

  SplashState copyWith({
    SplashStatus? status,
    bool? isLoggedIn,
  }) {
    return SplashState(
      status: status ?? this.status,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [status, isLoggedIn];
}
