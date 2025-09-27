import 'dart:io';

import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/service/profile_servide.dart';
import 'package:flutter_bump_app/data/model/request/update_profile_request.dart';
import 'package:flutter_bump_app/utils/image_picker_handler.dart';
import 'package:image_picker/image_picker.dart';

import 'update_profile_state.dart';

class UpdateProfileCubit extends BaseCubit<UpdateProfileState> {
  late final ProfileServide profileServide = locator.get();
  late final AccountService accountService = locator.get();

  UpdateProfileCubit() : super(const UpdateProfileState()) {
    _loadCurrentUserData();
  }

  void _loadCurrentUserData() {
    // Load current user data from service
    final currentUser = accountService.myAccount.value;
    emit(state.copyWith(
      name: currentUser?.name,
      bio: currentUser?.bio,
      gender: currentUser?.gender,
      // avatarPath: currentUser.avatar,
    ));
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateBio(String bio) {
    emit(state.copyWith(bio: bio));
  }

  void updateGender(UserGender gender) {
    emit(state.copyWith(gender: gender));
  }

  Future<void> pickAvatarCamera() async {
    try {
      final File? image = await ImagePickerHandler.onGetImage(
        source: ImageSource.camera,
      );

      if (image != null) {
        emit(state.copyWith(avatarPath: image.path));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to take photo'));
    }
  }

  Future<void> pickAvatarGallery() async {
    try {
      final File? image = await ImagePickerHandler.onGetImage();

      if (image != null) {
        emit(state.copyWith(avatarPath: image.path));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to pick image'));
    }
  }

  void removeAvatar() {
    emit(state.copyWith(clearAvatar: true));
  }

  Future<void> saveProfile() async {
    if (state.name.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Name is required'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      await profileServide.updateProfile(
        UpdateProfileRequest(
          name: state.name.trim(),
          bio: state.bio.trim(),
          gender: state.gender?.name ?? UserGender.OTHER.name,
        ),
      );

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update profile. Please try again.',
      ));
    }
  }
}
