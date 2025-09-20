import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/splash/splash_cubit.dart';

import 'splash_state.dart';

@RoutePage()
class SplashPage extends BaseBlocProvider<SplashState, SplashCubit> {
  const SplashPage({super.key});

  @override
  Widget buildPage() {
    return const SplashScreen();
  }

  @override
  SplashCubit createCubit() {
    return SplashCubit(
      accountService: locator.get(),
      localStorage: locator.get(),
      accountRepository: locator.get(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState
    extends BaseBlocNoAppBarPageState<SplashScreen, SplashState, SplashCubit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeSplash();
    });
  }

  @override
  String get title => 'Splash';

  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, SplashCubit cubit) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.isNavigating) {
          if (cubit.accountService.isLoggedIn) {
            context.replaceRoute(const DashboardRoute());
          } else {
            context.replaceRoute(const SignInRoute());
          }
          // context.replaceRoute(const SigninRoute());
          // if (state.isLoggedIn) {
          // context.replaceRoute(const DashboardRoute());
          // } else {
          // context.router.pushAndClearStack('/onboarding');
          // }
        }
      },
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    appTheme.blue600,
                    appTheme.blue800,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Main content area
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // App Logo
                          if (state.showLogo)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                              child: _buildLogo(),
                            ),

                          SizedBox(height: 48.h),

                          // App Name
                          Text(
                            'Highlight Creator',
                            style: AppStyle.bold32(color: appTheme.alpha),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 8.h),

                          // App Tagline
                          Text(
                            'AI-Powered Video Highlights',
                            style: AppStyle.regular16(
                                color: appTheme.alpha.withOpacity(0.8)),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 64.h),

                          // Loading Section
                          _buildLoadingSection(state),
                        ],
                      ),
                    ),

                    // Footer
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: appTheme.alpha,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.blackColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.video_library,
                  size: 60,
                  color: appTheme.blue600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingSection(SplashState state) {
    if (state.hasError) {
      return _buildErrorSection(state);
    }

    return Column(
      children: [
        // Loading Text
        Text(
          state.loadingText,
          style: AppStyle.medium16(color: appTheme.alpha.withOpacity(0.9)),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 24.h),

        // Progress Indicator
        if (state.showProgressBar) ...[
          Container(
            width: 200.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: appTheme.alpha.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: state.loadingProgress,
              child: Container(
                decoration: BoxDecoration(
                  color: appTheme.alpha,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${(state.loadingProgress * 100).round()}%',
            style: AppStyle.regular14(color: appTheme.alpha.withOpacity(0.7)),
          ),
        ] else ...[
          // Circular progress for auth checking
          SizedBox(
            width: 32.w,
            height: 32.h,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(appTheme.alpha),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildErrorSection(SplashState state) {
    return Column(
      children: [
        Icon(
          Icons.error_outline,
          size: 48,
          color: appTheme.red400,
        ),
        SizedBox(height: 16.h),
        Text(
          'Oops! Something went wrong',
          style: AppStyle.bold18(color: appTheme.alpha),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        if (state.errorMessage != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              state.errorMessage!,
              style: AppStyle.regular14(color: appTheme.alpha.withOpacity(0.8)),
              textAlign: TextAlign.center,
            ),
          ),
        SizedBox(height: 24.h),
        SizedBox(
          height: 48.h,
          child: ElevatedButton(
            onPressed: cubit.retryInitialization,
            style: ElevatedButton.styleFrom(
              backgroundColor: appTheme.alpha,
              foregroundColor: appTheme.blue600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.refresh,
                  size: 20,
                  color: appTheme.blue600,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Try Again',
                  style: AppStyle.medium16(color: appTheme.blue600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'powered by',
                style: AppStyle.regular14(
                  color: appTheme.alpha.withOpacity(0.6),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'memories.ai',
                style: AppStyle.medium14(color: appTheme.alpha),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Version 1.0.0',
            style: AppStyle.regular12(
              color: appTheme.alpha.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
