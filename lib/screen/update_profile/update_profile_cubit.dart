import 'dart:developer';

import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:image_picker/image_picker.dart';

import 'update_profile_state.dart';

class UpdateProfileCubit extends BaseCubit<UpdateProfileState> {
  late final AccountService accountService = locator.get();
  final ImagePicker _imagePicker = ImagePicker();

  UpdateProfileCubit() : super(const UpdateProfileState());

  void initializeProfile() {
    // Initialize with current user data
    emit(state.copyWith(
      fullName: 'John Doe',
      email: 'john.doe@email.com',
      phoneNumber: '+1 (555) 123-4567',
      birthYear: '1990',
      gender: 'Male',
      location: 'San Francisco, CA',
      bio: 'Passionate pickleball player and highlight creator',
      hasChanges: false,
    ));
  }

  void updateFullName(String fullName) {
    emit(state.copyWith(
      fullName: fullName,
      hasChanges: true,
    ));
  }

  void updateEmail(String email) {
    emit(state.copyWith(
      email: email,
      hasChanges: true,
    ));
  }

  void updatePhoneNumber(String phoneNumber) {
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      hasChanges: true,
    ));
  }

  void updateBirthYear(String birthYear) {
    emit(state.copyWith(
      birthYear: birthYear,
      hasChanges: true,
    ));
  }

  void updateGender(String gender) {
    emit(state.copyWith(
      gender: gender,
      hasChanges: true,
    ));
  }

  void updateLocation(String location) {
    emit(state.copyWith(
      location: location,
      hasChanges: true,
    ));
  }

  void updateBio(String bio) {
    emit(state.copyWith(
      bio: bio,
      hasChanges: true,
    ));
  }

  void resetChanges() {
    emit(state.copyWith(
      hasChanges: false,
    ));
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (image != null) {
        emit(state.copyWith(
          profileImagePath: image.path,
          hasChanges: true,
        ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (image != null) {
        emit(state.copyWith(
          profileImagePath: image.path,
          hasChanges: true,
        ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> saveProfile() async {
    if (!state.hasChanges) return true;

    emit(state.copyWith(isSaving: true));

    try {
      // Call API to save profile
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Here you would call your actual API
      // final result = await accountService.updateProfile({
      //   'fullName': state.fullName,
      //   'email': state.email,
      //   'phoneNumber': state.phoneNumber,
      //   'birthYear': state.birthYear,
      //   'gender': state.gender,
      //   'location': state.location,
      //   'bio': state.bio,
      //   'profileImage': state.profileImagePath,
      // });

      emit(state.copyWith(
        isSaving: false,
        hasChanges: false,
      ));

      // showSuccess('Profile updated successfully!');
      return true;
    } catch (e) {
      emit(state.copyWith(isSaving: false));
      return false;
    }
  }

  String? validateForm() {
    if (state.fullName.trim().isEmpty) {
      return 'Full name is required';
    }

    if (state.email.trim().isEmpty) {
      return 'Email is required';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(state.email)) {
      return 'Please enter a valid email';
    }

    if (state.phoneNumber.trim().isEmpty) {
      return 'Phone number is required';
    }

    if (state.birthYear.trim().isEmpty) {
      return 'Birth year is required';
    }

    final year = int.tryParse(state.birthYear);
    if (year == null || year < 1900 || year > DateTime.now().year) {
      return 'Please enter a valid year';
    }

    if (state.location.trim().isEmpty) {
      return 'Location is required';
    }

    return null; // No errors
  }
}
