import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/sign_in/sign_in_cubit.dart';
import 'package:flutter_bump_app/screen/sign_in/sign_in_state.dart';
import 'package:flutter_bump_app/utils/flash/toast.dart';

@RoutePage()
class SignInPage extends BaseBlocProvider<SignInState, SignInCubit> {
  const SignInPage({super.key});

  @override
  Widget buildPage() {
    return const SignInScreen();
  }

  @override
  SignInCubit createCubit() {
    return SignInCubit(
      authService: locator.get(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState
    extends BaseBlocNoAppBarPageState<SignInScreen, SignInState, SignInCubit> {
  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, SignInCubit cubit) {
    return BlocConsumer<SignInCubit, SignInState>(
      bloc: cubit,
      buildWhen: (previous, current) => false,
      listener: (context, state) {
        if (state.isSuccess == true) {
          showSimpleToast('Sign in successfully');
          context.replaceRoute(const HomeRoute());
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0F172A), // #0F172A
                Color(0xFF1E293B), // #1E293B
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: padding(horizontal: 24.w, vertical: 48.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  SizedBox(height: 32.h),
                  _buildTitle(),
                  SizedBox(height: 8.h),
                  _buildStats(),
                  SizedBox(height: 36.h),
                  _buildSignInButton(cubit, state),
                ],
              ),
            ),
          ),
        );
      },
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 96.w,
                  height: 96.h,
                  decoration: BoxDecoration(
                    color: appTheme.green4AColor.withSafeOpacity(0.1),
                    borderRadius: BorderRadius.circular(48),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.green4AColor.withSafeOpacity(0.3),
                        blurRadius: 60,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 96.w,
                  height: 96.h,
                  decoration: BoxDecoration(
                    color: appTheme.green4AColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.rocket_launch,
                      size: 48.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SPONSOR.FUN',
              style: AppStyle.bold32(color: appTheme.green4AColor),
            ),
            SizedBox(width: 8.w),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -4 * (1 - value).abs()),
                  child: Icon(
                    Icons.rocket_launch,
                    size: 24.w,
                    color: appTheme.green4AColor,
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'Sponsor The Movement You Believe In!',
          style: AppStyle.regular16(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatItem(
          icon: Icons.local_fire_department,
          iconColor: Colors.orange,
          text: '10K+ Creators',
        ),
        SizedBox(width: 24.w),
        _buildStatItem(
          icon: Icons.account_balance_wallet,
          iconColor: appTheme.green69Color,
          text: '₿ 2,847 SOL Paid',
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12.w,
          color: iconColor,
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: AppStyle.regular12(color: Colors.white60),
        ),
      ],
    );
  }

  Widget _buildSignInButton(SignInCubit cubit, SignInState state) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ElevatedButton(
        onPressed: state.isLoading ? null : () => cubit.signInWithGoogle(),
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.transparentColor,
          foregroundColor: appTheme.whiteText,
          shadowColor: appTheme.green81Color.withSafeOpacity(0.25),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [appTheme.green4AColor, appTheme.green69Color],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            alignment: Alignment.center,
            child: state.isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        appTheme.whiteText,
                      ),
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Continue with Gmail',
                    style: AppStyle.medium16(color: appTheme.whiteText),
                  ),
          ),
        ),
      ),
    );
  }
}
