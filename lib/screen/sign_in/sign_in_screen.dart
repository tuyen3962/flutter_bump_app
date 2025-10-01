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
          decoration: BoxDecoration(
            color: appTheme.greenF4Color,
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildMainContent()),
                _buildBottomWidget(cubit),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: padding(top: 48.h, bottom: 32.h),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (0.2 * value),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          appTheme.green81Color,
                          appTheme.green69Color,
                          appTheme.green4AColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: appTheme.green81Color.withSafeOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: appTheme.whiteText,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  appTheme.green81Color,
                                  appTheme.green69Color,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 24.h),
          Text(
            'Clipit',
            style: AppStyle.bold32(color: appTheme.green2DColor),
          ),
          SizedBox(height: 8.h),
          Text(
            'Next-gen content validation',
            style: AppStyle.regular16(color: appTheme.green3DColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: padding(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 24.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppStyle.regular20(color: appTheme.green2DColor),
                  children: [
                    TextSpan(
                      text: 'Your vision',
                      style: AppStyle.regular20(color: appTheme.green3DColor),
                    ),
                    const TextSpan(text: ', '),
                    TextSpan(
                      text: 'your video',
                      style: AppStyle.regular20(color: appTheme.green57Color),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppStyle.regular20(color: appTheme.green2DColor),
                  children: [
                    const TextSpan(text: 'Your '),
                    TextSpan(
                      text: 'reward',
                      style: AppStyle.regular20(color: appTheme.green3DColor),
                    ),
                    const TextSpan(text: ', with '),
                    TextSpan(
                      text: 'Clipit',
                      style: AppStyle.bold20(
                        color: appTheme.green4AColor,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: 64.w,
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      appTheme.transparentColor,
                      appTheme.green80Color,
                      appTheme.transparentColor,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomWidget(SignInCubit cubit) {
    return Padding(
      padding: padding(left: 24.w, right: 24.w, bottom: 32.h),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed:
                  cubit.state.isLoading ? null : () => cubit.signInWithGoogle(),
              style: ElevatedButton.styleFrom(
                backgroundColor: appTheme.transparentColor,
                foregroundColor: appTheme.whiteText,
                shadowColor: appTheme.green81Color.withSafeOpacity(0.25),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [appTheme.green4AColor, appTheme.green69Color],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in with Google',
                        style: AppStyle.medium16(color: appTheme.whiteText),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward,
                        color: appTheme.whiteText,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'By continuing, you agree to our Terms & Privacy Policy',
            textAlign: TextAlign.center,
            style: AppStyle.regular14(
              color: appTheme.green3DColor,
            ),
          ),
        ],
      ),
    );
  }
}
