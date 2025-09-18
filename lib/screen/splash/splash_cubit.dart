import 'dart:async';

import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  late final AccountService accountService = locator.get();

  SplashCubit() : super(const SplashState());

  void initializeSplash() {
    _startSplashSequence();
  }

  Future<void> _startSplashSequence() async {
    try {
      // Phase 1: Initial loading
      emit(state.copyWith(
        status: SplashStatus.loading,
        loadingText: 'Initializing app...',
        loadingProgress: 0.0,
      ));

      // Simulate app initialization steps
      await _simulateLoadingSteps();

      // Phase 2: Check authentication
      emit(state.copyWith(
        status: SplashStatus.checkingAuth,
        loadingText: 'Checking authentication...',
        loadingProgress: 0.8,
      ));

      await Future.delayed(const Duration(milliseconds: 500));

      // Simulate auth check
      final isLoggedIn = await _checkAuthentication();

      emit(state.copyWith(
        isLoggedIn: isLoggedIn,
        loadingProgress: 1.0,
      ));

      // Phase 3: Navigate to appropriate screen
      emit(state.copyWith(
        status: SplashStatus.navigating,
        loadingText: 'Launching app...',
      ));

      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      emit(state.copyWith(
        status: SplashStatus.error,
        errorMessage: 'Failed to initialize app. Please try again.',
      ));
    }
  }

  Future<void> _simulateLoadingSteps() async {
    final loadingSteps = [
      {'text': 'Loading core modules...', 'progress': 0.1},
      {'text': 'Setting up database...', 'progress': 0.2},
      {'text': 'Loading user preferences...', 'progress': 0.3},
      {'text': 'Initializing video engine...', 'progress': 0.5},
      {'text': 'Connecting to services...', 'progress': 0.7},
    ];

    for (final step in loadingSteps) {
      emit(state.copyWith(
        loadingText: step['text'] as String,
        loadingProgress: step['progress'] as double,
      ));

      await Future.delayed(const Duration(milliseconds: 400));
    }
  }

  Future<bool> _checkAuthentication() async {
    try {
      // Simulate auth check - in real app, check stored tokens
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock logic: return true if user has valid session
      // In real app: return await accountService.isLoggedIn();

      // For demo, randomly return true/false or check stored preferences
      return true; // Change this to false to test onboarding flow
    } catch (e) {
      return false;
    }
  }

  void retryInitialization() {
    emit(const SplashState());
    _startSplashSequence();
  }

  void hideProgressBar() {
    emit(state.copyWith(showProgressBar: false));
  }

  void hideLogo() {
    emit(state.copyWith(showLogo: false));
  }
}
