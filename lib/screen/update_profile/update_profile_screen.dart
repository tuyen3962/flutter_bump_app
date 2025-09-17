import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/update_profile/update_profile_cubit.dart';

import 'update_profile_state.dart';

@RoutePage()
class UpdateProfilePage extends BaseBlocProvider<UpdateProfileState, UpdateProfileCubit> {
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

class UpdateProfileScreenState
    extends BaseBlocNoAppBarPageState<UpdateProfileScreen, UpdateProfileState, UpdateProfileCubit> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthYearController = TextEditingController();
  final _locationController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  String get title => 'Edit Profile';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeProfile();
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthYearController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context, UpdateProfileCubit cubit) {
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        _updateControllers(state);
      },
      child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appTheme.alpha,
            body: Column(
              children: [
                // Header
                _buildHeader(state),

                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: padding(all: 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Profile Picture
                            _buildProfilePicture(state),

                            SizedBox(height: 32.h),

                            // Form Fields
                            _buildTextField(
                              controller: _fullNameController,
                              label: 'Full Name',
                              icon: Icons.person_outline,
                              onChanged: cubit.updateFullName,
                            ),

                            SizedBox(height: 20.h),

                            _buildTextField(
                              controller: _emailController,
                              label: 'Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: cubit.updateEmail,
                            ),

                            SizedBox(height: 20.h),

                            _buildTextField(
                              controller: _phoneController,
                              label: 'Phone Number',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              onChanged: cubit.updatePhoneNumber,
                            ),

                            SizedBox(height: 20.h),

                            _buildTextField(
                              controller: _birthYearController,
                              label: 'Birth Year',
                              icon: Icons.calendar_today_outlined,
                              keyboardType: TextInputType.number,
                              onChanged: cubit.updateBirthYear,
                            ),

                            SizedBox(height: 20.h),

                            // Gender Dropdown
                            _buildGenderDropdown(state),

                            SizedBox(height: 20.h),

                            _buildTextField(
                              controller: _locationController,
                              label: 'Location',
                              icon: Icons.location_on_outlined,
                              onChanged: cubit.updateLocation,
                            ),

                            SizedBox(height: 20.h),

                            _buildTextField(
                              controller: _bioController,
                              label: 'Bio',
                              icon: Icons.info_outline,
                              maxLines: 3,
                              maxLength: 150,
                              onChanged: cubit.updateBio,
                            ),

                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(UpdateProfileState state) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray200,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _onBackPressed(state),
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: appTheme.transparentColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: appTheme.gray600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Edit Profile',
                style: AppStyle.bold18(),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: state.hasChanges && !state.isSaving ? _saveChanges : null,
              child: Container(
                padding: padding(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: state.hasChanges && !state.isSaving ? appTheme.blue500 : appTheme.gray200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: state.isSaving
                    ? SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(appTheme.alpha),
                        ),
                      )
                    : Text(
                        'Save',
                        style: AppStyle.medium14(
                          color: state.hasChanges && !state.isSaving ? appTheme.alpha : appTheme.gray400,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture(UpdateProfileState state) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: appTheme.blue100,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: state.profileImagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.file(
                          File(state.profileImagePath!),
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Text(
                          'JD',
                          style: AppStyle.bold30(color: appTheme.blue600),
                        ),
                      ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: _changeProfilePicture,
                  child: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: appTheme.blue500,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: appTheme.alpha,
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: appTheme.alpha,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: _changeProfilePicture,
            child: Text(
              'Change Photo',
              style: AppStyle.medium14(color: appTheme.blue500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.medium16(color: appTheme.gray700),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          style: AppStyle.regular16(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: appTheme.gray600,
              size: 20,
            ),
            hintText: 'Enter your $label',
            hintStyle: AppStyle.regular16(color: appTheme.gray400),
            filled: true,
            fillColor: appTheme.alpha,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appTheme.gray300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appTheme.gray300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appTheme.blue500, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appTheme.red500),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appTheme.red500, width: 2),
            ),
            contentPadding: padding(
              horizontal: 16.w,
              vertical: maxLines > 1 ? 16.h : 14.h,
            ),
            counterStyle: AppStyle.regular12(color: appTheme.gray500),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown(UpdateProfileState state) {
    final genderOptions = ['Male', 'Female', 'Other'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: AppStyle.medium16(color: appTheme.gray700),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: padding(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: appTheme.gray300),
            borderRadius: BorderRadius.circular(12),
            color: appTheme.alpha,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: state.gender,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: appTheme.gray600,
              ),
              style: AppStyle.regular16(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  cubit.updateGender(newValue);
                }
              },
              items: genderOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 20,
                        color: appTheme.gray600,
                      ),
                      SizedBox(width: 12.w),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _updateControllers(UpdateProfileState state) {
    if (_fullNameController.text != state.fullName) {
      _fullNameController.text = state.fullName;
    }
    if (_emailController.text != state.email) {
      _emailController.text = state.email;
    }
    if (_phoneController.text != state.phoneNumber) {
      _phoneController.text = state.phoneNumber;
    }
    if (_birthYearController.text != state.birthYear) {
      _birthYearController.text = state.birthYear;
    }
    if (_locationController.text != state.location) {
      _locationController.text = state.location;
    }
    if (_bioController.text != state.bio) {
      _bioController.text = state.bio;
    }
  }

  void _changeProfilePicture() {
    showModalBottomSheet(
      context: context,
      backgroundColor: appTheme.alpha,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: padding(all: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: appTheme.gray300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Change Profile Photo',
                style: AppStyle.bold18(),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        cubit.pickImageFromCamera();
                      },
                      child: Container(
                        padding: padding(vertical: 16),
                        decoration: BoxDecoration(
                          color: appTheme.gray50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 32,
                              color: appTheme.gray600,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Camera',
                              style: AppStyle.medium14(color: appTheme.gray700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        cubit.pickImageFromGallery();
                      },
                      child: Container(
                        padding: padding(vertical: 16),
                        decoration: BoxDecoration(
                          color: appTheme.gray50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.photo_library,
                              size: 32,
                              color: appTheme.gray600,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Gallery',
                              style: AppStyle.medium14(color: appTheme.gray700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  void _onBackPressed(UpdateProfileState state) {
    if (state.hasChanges) {
      _showUnsavedChangesDialog();
    } else {
      context.back();
    }
  }

  void _showUnsavedChangesDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: appTheme.alpha,
          child: Container(
            padding: padding(all: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 48,
                  color: appTheme.amber500,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Unsaved Changes',
                  style: AppStyle.bold20(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'You have unsaved changes. Are you sure you want to leave?',
                  style: AppStyle.regular16(color: appTheme.gray600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: appTheme.gray700,
                            side: BorderSide(color: appTheme.gray300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Stay',
                            style: AppStyle.medium16(color: appTheme.gray700),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appTheme.red500,
                            foregroundColor: appTheme.alpha,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Leave',
                            style: AppStyle.medium16(color: appTheme.alpha),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveChanges() async {
    final validationError = cubit.validateForm();
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            validationError,
            style: AppStyle.medium14(color: appTheme.alpha),
          ),
          backgroundColor: appTheme.red500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: padding(all: 16),
        ),
      );
      return;
    }

    final success = await cubit.saveProfile();
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile updated successfully!',
            style: AppStyle.medium14(color: appTheme.alpha),
          ),
          backgroundColor: appTheme.green500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: padding(all: 16),
        ),
      );

      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          context.back();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update profile. Please try again.',
            style: AppStyle.medium14(color: appTheme.alpha),
          ),
          backgroundColor: appTheme.red500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: padding(all: 16),
        ),
      );
    }
  }
}
