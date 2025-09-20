import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/gen/assets.gen.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/signin/signin_cubit.dart';
import 'package:flutter_bump_app/screen/signin/signin_state.dart';
import 'package:flutter_bump_app/utils/flash/toast.dart';
import 'package:flutter_bump_app/widget/primary_button.dart';

@RoutePage()
class SigninPage extends BaseBlocProvider<SigninState, SigninCubit> {
  const SigninPage({super.key});

  @override
  Widget buildPage() {
    return const SigninScreen();
  }

  @override
  SigninCubit createCubit() {
    return SigninCubit(
      authService: locator.get(),
    );
  }
}

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => SigninScreenState();
}

class SigninScreenState
    extends BaseBlocNoAppBarPageState<SigninScreen, SigninState, SigninCubit> {
  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, SigninCubit cubit) {
    return BlocConsumer<SigninCubit, SigninState>(
        bloc: cubit,
        buildWhen: (previous, current) => false,
        listener: (context, state) {
          if (state.isSuccess == true) {
            showSimpleToast('Sign in successfully');
            context.replaceRoute(const DashboardRoute());
          }
        },
        builder: (context, state) {
          return Container(
            padding: padding(horizontal: 16),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.bgSplash.path),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Turn your pickleball matches into epic highlight reels',
                  style: AppStyle.bold14(color: appTheme.whiteText),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: 'Sign in with Google',
                  onTap: cubit.state.isLoading
                      ? null
                      : () => cubit.signInWithGoogle(),
                  fontSize: 16.fontSize,
                  weight: FontWeight.w600,
                  buttonPadding: padding(all: 16),
                  isFullWidth: false,
                  backgroundColor: appTheme.whiteText,
                  textColor: appTheme.blackColor,
                  radius: 12,
                ),
              ],
            ),
          );
        });
  }
}
