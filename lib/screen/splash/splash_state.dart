import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum SplashStatus { loading, checkingAuth, navigating, error }

class SplashState extends BaseState {
  final SplashStatus status;
  final double loadingProgress;
  final String loadingText;
  final bool isLoggedIn;
  final String? errorMessage;
  final bool showLogo;
  final bool showProgressBar;

  const SplashState({
    this.status = SplashStatus.loading,
    this.loadingProgress = 0.0,
    this.loadingText = 'Loading...',
    this.isLoggedIn = false,
    this.errorMessage,
    this.showLogo = true,
    this.showProgressBar = true,
  });

  SplashState copyWith({
    SplashStatus? status,
    double? loadingProgress,
    String? loadingText,
    bool? isLoggedIn,
    String? errorMessage,
    bool? showLogo,
    bool? showProgressBar,
  }) {
    return SplashState(
      status: status ?? this.status,
      loadingProgress: loadingProgress ?? this.loadingProgress,
      loadingText: loadingText ?? this.loadingText,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage ?? this.errorMessage,
      showLogo: showLogo ?? this.showLogo,
      showProgressBar: showProgressBar ?? this.showProgressBar,
    );
  }

  bool get isLoading => status == SplashStatus.loading;
  bool get isCheckingAuth => status == SplashStatus.checkingAuth;
  bool get isNavigating => status == SplashStatus.navigating;
  bool get hasError => status == SplashStatus.error;

  @override
  List<Object?> get props => [
        status,
        loadingProgress,
        loadingText,
        isLoggedIn,
        errorMessage,
        showLogo,
        showProgressBar,
      ];
}
