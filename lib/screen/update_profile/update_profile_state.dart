import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';

class UpdateProfileState extends BaseState {
  final String name;
  final String bio;
  final UserGender? gender;
  final String? avatarPath;
  final bool isSuccess;
  final String errorMessage;

  const UpdateProfileState({
    super.isLoading = false,
    this.name = '',
    this.bio = '',
    this.gender,
    this.avatarPath,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  UpdateProfileState copyWith({
    String? name,
    String? bio,
    UserGender? gender,
    String? avatarPath,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? clearAvatar,
  }) {
    return UpdateProfileState(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      avatarPath: clearAvatar == true ? null : (avatarPath ?? this.avatarPath),
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        name,
        bio,
        gender,
        avatarPath,
        isSuccess,
        errorMessage,
      ];
}
