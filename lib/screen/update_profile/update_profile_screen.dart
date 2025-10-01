import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/update_profile/update_profile_cubit.dart';
import 'package:flutter_bump_app/utils/flash/toast.dart';

import 'update_profile_state.dart';

@RoutePage()
class UpdateProfilePage
    extends BaseBlocProvider<UpdateProfileState, UpdateProfileCubit> {
  const UpdateProfilePage({super.key});

  @override
  Widget buildPage() {
    return const UpdateProfileScreen();
  }

  @override
  UpdateProfileCubit createCubit() {
    return UpdateProfileCubit();
  }
}

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends BaseBlocNoAppBarPageState<
    UpdateProfileScreen, UpdateProfileState, UpdateProfileCubit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  bool get isSafeArea => false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = cubit.state;
      _nameController.text = state.name;
      _bioController.text = state.bio;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context, UpdateProfileCubit cubit) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.isSuccess) {
          showSimpleToast('Profile updated successfully');
          Navigator.pop(context);
        } else if (state.errorMessage.isNotEmpty) {
          showSimpleToast(state.errorMessage);
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
                _buildHeader(state, cubit),
                Expanded(
                  child: _buildContent(state, cubit),
                ),
                _buildBottomActions(state, cubit),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(UpdateProfileState state, UpdateProfileCubit cubit) {
    return Container(
      padding: padding(all: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: appTheme.green800Color.withSafeOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.close,
                color: appTheme.green800Color,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Edit Profile',
              textAlign: TextAlign.center,
              style: AppStyle.bold18(color: appTheme.green2DColor),
            ),
          ),
          GestureDetector(
            onTap: state.isLoading ? null : () => _saveProfile(cubit),
            child: Container(
              padding: padding(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: state.isLoading
                    ? appTheme.greyColor.withSafeOpacity(0.3)
                    : appTheme.green4AColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Save',
                style: AppStyle.medium14(
                  color:
                      state.isLoading ? appTheme.greyColor : appTheme.whiteText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(UpdateProfileState state, UpdateProfileCubit cubit) {
    return SingleChildScrollView(
      padding: padding(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 24.h),

          // Avatar Section
          _buildAvatarSection(state, cubit),

          SizedBox(height: 32.h),

          // Name Field
          _buildNameField(state, cubit),

          SizedBox(height: 24.h),

          // Bio Field
          _buildBioField(state, cubit),

          SizedBox(height: 24.h),

          // Gender Selection
          _buildGenderSelection(state, cubit),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildAvatarSection(
      UpdateProfileState state, UpdateProfileCubit cubit) {
    return Column(
      children: [
        Text(
          'Profile Picture',
          style: AppStyle.medium16(color: appTheme.green2DColor),
        ),
        SizedBox(height: 16.h),
        GestureDetector(
          onTap: () => _showAvatarOptions(cubit),
          child: Stack(
            children: [
              Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      appTheme.green81Color.withSafeOpacity(0.8),
                      appTheme.green69Color.withSafeOpacity(0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.green81Color.withSafeOpacity(0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: appTheme.green300.withSafeOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: state.avatarPath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.asset(
                          state.avatarPath!,
                          fit: BoxFit.cover,
                          width: 120.w,
                          height: 120.h,
                        ),
                      )
                    : Center(
                        child: Container(
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                appTheme.green200Color.withSafeOpacity(0.5),
                                appTheme.emerald200Color.withSafeOpacity(0.5),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              state.name.isNotEmpty
                                  ? state.name[0].toUpperCase()
                                  : 'A',
                              style: AppStyle.bold24(
                                  color: appTheme.green800Color),
                            ),
                          ),
                        ),
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: appTheme.green4AColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: appTheme.whiteText,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.blackColor.withSafeOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: appTheme.whiteText,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNameField(UpdateProfileState state, UpdateProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name',
          style: AppStyle.medium16(color: appTheme.green2DColor),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _nameController,
          onChanged: cubit.updateName,
          decoration: InputDecoration(
            hintText: 'Enter your full name',
            hintStyle: AppStyle.regular16(
              color: appTheme.green600.withSafeOpacity(0.6),
            ),
            filled: true,
            fillColor: appTheme.whiteText.withSafeOpacity(0.6),
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
      ],
    );
  }

  Widget _buildBioField(UpdateProfileState state, UpdateProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bio',
          style: AppStyle.medium16(color: appTheme.green2DColor),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _bioController,
          onChanged: cubit.updateBio,
          maxLines: 3,
          maxLength: 150,
          decoration: InputDecoration(
            hintText: 'Tell us about yourself...',
            hintStyle: AppStyle.regular16(
              color: appTheme.green600.withSafeOpacity(0.6),
            ),
            filled: true,
            fillColor: appTheme.whiteText.withSafeOpacity(0.6),
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
            counterStyle: AppStyle.regular12(
              color: appTheme.green600.withSafeOpacity(0.6),
            ),
          ),
          style: AppStyle.regular16(color: appTheme.green2DColor),
        ),
      ],
    );
  }

  Widget _buildGenderSelection(
      UpdateProfileState state, UpdateProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: AppStyle.medium16(color: appTheme.green2DColor),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: UserGender.values.map((gender) {
            final isSelected = state.gender == gender;
            return GestureDetector(
              onTap: () => cubit.updateGender(gender),
              child: Container(
                padding: padding(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? appTheme.green4AColor.withSafeOpacity(0.2)
                      : appTheme.whiteText.withSafeOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? appTheme.green4AColor
                        : appTheme.green300.withSafeOpacity(0.5),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  gender.name,
                  style: AppStyle.medium14(
                    color: isSelected
                        ? appTheme.green4AColor
                        : appTheme.green2DColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomActions(
      UpdateProfileState state, UpdateProfileCubit cubit) {
    return Container(
      padding: padding(all: 24.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: state.isLoading ? null : () => _saveProfile(cubit),
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
                colors: state.isLoading
                    ? [
                        appTheme.greyColor.withSafeOpacity(0.5),
                        appTheme.greyColor.withSafeOpacity(0.5),
                      ]
                    : [appTheme.green4AColor, appTheme.green69Color],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Container(
              alignment: Alignment.center,
              child: state.isLoading
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
                          'Saving...',
                          style: AppStyle.medium16(color: appTheme.whiteText),
                        ),
                      ],
                    )
                  : Text(
                      'Save Changes',
                      style: AppStyle.medium18(color: appTheme.whiteText),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveProfile(UpdateProfileCubit cubit) {
    if (_nameController.text.trim().isEmpty) {
      showSimpleToast('Please enter your name');
      return;
    }

    cubit.saveProfile();
  }

  void _showAvatarOptions(UpdateProfileCubit cubit) {
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
                  children: [
                    Text(
                      'Change Profile Picture',
                      style: AppStyle.bold18(color: appTheme.green2DColor),
                    ),
                    SizedBox(height: 20.h),

                    // Camera option
                    _buildAvatarOption(
                      'Take Photo',
                      Icons.camera_alt,
                      () {
                        Navigator.pop(context);
                        cubit.pickAvatarCamera();
                      },
                    ),

                    SizedBox(height: 12.h),

                    // Gallery option
                    _buildAvatarOption(
                      'Choose from Gallery',
                      Icons.photo_library,
                      () {
                        Navigator.pop(context);
                        cubit.pickAvatarGallery();
                      },
                    ),

                    SizedBox(height: 12.h),

                    // Remove option
                    if (cubit.state.avatarPath != null)
                      _buildAvatarOption(
                        'Remove Photo',
                        Icons.delete_outline,
                        () {
                          Navigator.pop(context);
                          cubit.removeAvatar();
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatarOption(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding(all: 16.w),
        decoration: BoxDecoration(
          color: appTheme.whiteText.withSafeOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: appTheme.green300.withSafeOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: appTheme.green2DColor,
              size: 24,
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: AppStyle.medium16(color: appTheme.green2DColor),
            ),
          ],
        ),
      ),
    );
  }
}
