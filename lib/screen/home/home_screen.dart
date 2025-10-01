import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/stream/base_stream_builder.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/router/app_route.dart';
import 'package:flutter_bump_app/screen/home/home_cubit.dart';
import 'package:flutter_bump_app/screen/home/home_state.dart';

@RoutePage()
class HomePage extends BaseBlocProvider<HomeState, HomeCubit> {
  const HomePage({super.key});

  @override
  Widget buildPage() {
    return const HomeScreen();
  }

  @override
  HomeCubit createCubit() {
    return HomeCubit(
      profileServide: locator.get(),
      accountService: locator.get(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState
    extends BaseBlocNoAppBarPageState<HomeScreen, HomeState, HomeCubit> {
  final TextEditingController _videoUrlController = TextEditingController();

  @override
  bool get isSafeArea => false;

  @override
  void dispose() {
    _videoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context, HomeCubit cubit) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: appTheme.greenF4Color),
        child: Column(
          children: [
            _buildHeader(state, cubit),
            Expanded(
              child: _buildMainContent(state, cubit),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(HomeState state, HomeCubit cubit) {
    return BaseStreamBuilder(
      controller: cubit.accountService.myAccount,
      builder: (user) {
        return Container(
          padding: padding(top: 48, horizontal: 16, bottom: 16),
          decoration: BoxDecoration(
            gradient: _getHeaderGradient(state),
            border: Border(
              bottom: BorderSide(
                color: appTheme.whiteText.withSafeOpacity(0.1),
                width: 1.w,
              ),
            ),
          ),
          child: Row(
            children: [
              // Profile Button
              GestureDetector(
                onTap: () => context.pushRoute(const ProfileRoute()),
                child: Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: appTheme.whiteText,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.blackColor.withSafeOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: appTheme.whiteText.withSafeOpacity(0.2),
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      (user?.name ?? '').isNotEmpty
                          ? user!.name![0].toUpperCase()
                          : 'A',
                      style: AppStyle.bold16(color: appTheme.green800Color),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${user?.name ?? 'User'}',
                      style: AppStyle.regular16(color: appTheme.whiteText),
                    ),
                    Text(
                      user?.bio ?? 'Welcome back to Bump!',
                      style: AppStyle.regular14(color: appTheme.green800Color),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => cubit.navigateToActivity(),
                child: Container(
                  padding: padding(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        appTheme.yellowColor.withSafeOpacity(0.2),
                        appTheme.orangeColor.withSafeOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: appTheme.yellowColor.withSafeOpacity(0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '⚡',
                        style:
                            AppStyle.regular14(color: appTheme.yellow800Color),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainContent(HomeState state, HomeCubit cubit) {
    return SingleChildScrollView(
      padding: padding(all: 24.w),
      child: Column(
        children: [
          SizedBox(height: 32.h),

          // Brand Selection
          _buildBrandSelection(state, cubit),

          SizedBox(height: 32.h),

          // Video URL Input
          _buildVideoUrlInput(state, cubit),

          SizedBox(height: 32.h),

          // Validation Button
          _buildValidationButton(state, cubit),

          SizedBox(height: 24.h),

          // Validation Result
          if (state.validationState != ValidationResultState.idle &&
              state.validationState != ValidationResultState.valid)
            _buildValidationResult(state),
        ],
      ),
    );
  }

  Widget _buildBrandSelection(HomeState state, HomeCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Brand',
          style: AppStyle.medium18(color: appTheme.green2DColor),
        ),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: () => _showBrandSelector(state, cubit),
          child: Container(
            width: double.infinity,
            height: 48.h,
            padding: padding(horizontal: 16.w),
            decoration: BoxDecoration(
              color: appTheme.whiteText.withSafeOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: appTheme.green300.withSafeOpacity(0.5),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: appTheme.blackColor.withSafeOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (state.selectedBrand != null) ...[
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(state.selectedBrand!.logo),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    state.selectedBrand!.name,
                    style: AppStyle.regular16(color: appTheme.green2DColor),
                  ),
                ] else
                  Text(
                    'Choose a brand to integrate',
                    style: AppStyle.regular16(
                      color: appTheme.green600.withSafeOpacity(0.6),
                    ),
                  ),
                const Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: appTheme.green2DColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoUrlInput(HomeState state, HomeCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Video URL',
          style: AppStyle.medium18(color: appTheme.green2DColor),
        ),
        SizedBox(height: 16.h),
        TextField(
          controller: _videoUrlController,
          onChanged: cubit.updateVideoUrl,
          decoration: InputDecoration(
            hintText: 'Paste your YouTube or TikTok URL here',
            hintStyle: AppStyle.regular16(
              color: appTheme.green600.withSafeOpacity(0.6),
            ),
            filled: true,
            fillColor: appTheme.whiteText.withSafeOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appTheme.green300.withSafeOpacity(0.5),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appTheme.green300.withSafeOpacity(0.5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: appTheme.green4AColor,
                width: 2,
              ),
            ),
            contentPadding: padding(horizontal: 16.w, vertical: 12.h),
          ),
          style: AppStyle.regular16(color: appTheme.green2DColor),
        ),
        SizedBox(height: 8.h),
        Text(
          'Supported platforms: YouTube, TikTok',
          style: AppStyle.regular14(color: appTheme.green800Color),
        ),
      ],
    );
  }

  Widget _buildValidationButton(HomeState state, HomeCubit cubit) {
    final isDisabled =
        state.validationState == ValidationResultState.validating ||
            state.selectedBrand == null ||
            state.videoUrl.isEmpty;

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isDisabled ? null : () => cubit.validateVideo(),
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.transparentColor,
          foregroundColor: appTheme.whiteText,
          shadowColor: _getBrandShadowColor(state),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: _getButtonGradient(state, isDisabled),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Container(
            alignment: Alignment.center,
            child: state.validationState == ValidationResultState.validating
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            appTheme.whiteText,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Validating...',
                        style: AppStyle.medium16(color: appTheme.whiteText),
                      ),
                    ],
                  )
                : Text(
                    'Validate Content',
                    style: AppStyle.medium18(color: appTheme.whiteText),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildValidationResult(HomeState state) {
    return Container(
      width: double.infinity,
      padding: padding(all: 24.w),
      decoration: BoxDecoration(
        color: _getValidationBackgroundColor(state),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getValidationBorderColor(state),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.blackColor.withSafeOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _getValidationIcon(state),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              state.validationMessage,
              style: AppStyle.regular16(
                color: _getValidationTextColor(state),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for brand theming
  LinearGradient _getHeaderGradient(HomeState state) {
    if (state.selectedBrand != null) {
      return LinearGradient(
        colors: state.selectedBrand!.theme.primaryColors
            .map((color) => color.withSafeOpacity(0.9))
            .toList(),
      );
    }
    return LinearGradient(
      colors: [
        appTheme.green600.withSafeOpacity(0.9),
        appTheme.green69Color.withSafeOpacity(0.9),
      ],
    );
  }

  LinearGradient _getButtonGradient(HomeState state, bool isDisabled) {
    if (isDisabled) {
      return LinearGradient(
        colors: [
          appTheme.greyColor.withSafeOpacity(0.5),
          appTheme.greyColor.withSafeOpacity(0.5),
        ],
      );
    }

    if (state.selectedBrand != null) {
      return LinearGradient(
        colors: state.selectedBrand!.theme.primaryColors,
      );
    }
    return LinearGradient(
      colors: [appTheme.green4AColor, appTheme.green69Color],
    );
  }

  Color _getBrandShadowColor(HomeState state) {
    if (state.selectedBrand != null) {
      return state.selectedBrand!.theme.primaryColors.first
          .withSafeOpacity(0.25);
    }
    return appTheme.green81Color.withSafeOpacity(0.25);
  }

  // Validation result styling
  Color _getValidationBackgroundColor(HomeState state) {
    switch (state.validationState) {
      case ValidationResultState.validating:
        return appTheme.yellowColor.withSafeOpacity(0.2);
      case ValidationResultState.invalid:
        return appTheme.redColor.withSafeOpacity(0.2);
      default:
        return appTheme.whiteText.withSafeOpacity(0.1);
    }
  }

  Color _getValidationBorderColor(HomeState state) {
    switch (state.validationState) {
      case ValidationResultState.validating:
        return appTheme.yellowColor.withSafeOpacity(0.5);
      case ValidationResultState.invalid:
        return appTheme.redColor.withSafeOpacity(0.5);
      default:
        return appTheme.whiteText.withSafeOpacity(0.2);
    }
  }

  Color _getValidationTextColor(HomeState state) {
    switch (state.validationState) {
      case ValidationResultState.validating:
        return appTheme.yellow900Color;
      case ValidationResultState.invalid:
        return appTheme.red900Color;
      default:
        return appTheme.grey300Color;
    }
  }

  Widget _getValidationIcon(HomeState state) {
    switch (state.validationState) {
      case ValidationResultState.validating:
        return Icon(
          Icons.warning_amber_rounded,
          color: appTheme.yellow400Color,
          size: 20,
        );
      case ValidationResultState.invalid:
        return Icon(
          Icons.cancel_rounded,
          color: appTheme.red400Color,
          size: 20,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  void _showBrandSelector(HomeState state, HomeCubit cubit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: appTheme.transparentColor,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: appTheme.greenF4Color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: padding(top: 12.h, bottom: 20.h),
                decoration: BoxDecoration(
                  color: appTheme.greyColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: padding(horizontal: 24.w, bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Brand',
                      style: AppStyle.bold20(color: appTheme.green2DColor),
                    ),
                    SizedBox(height: 16.h),
                    ...state.availableBrands.map((brand) {
                      return GestureDetector(
                        onTap: () {
                          cubit.selectBrand(brand);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: padding(all: 16.w),
                          margin: padding(bottom: 12.h),
                          decoration: BoxDecoration(
                            color: appTheme.whiteText.withSafeOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: state.selectedBrand?.id == brand.id
                                  ? appTheme.green4AColor
                                  : appTheme.green300.withSafeOpacity(0.3),
                              width:
                                  state.selectedBrand?.id == brand.id ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(brand.logo),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                brand.name,
                                style: AppStyle.medium16(
                                  color: appTheme.green2DColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
