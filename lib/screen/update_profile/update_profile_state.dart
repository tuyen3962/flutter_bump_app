import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class UpdateProfileState extends BaseState {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String birthYear;
  final String gender;
  final String location;
  final String bio;
  final bool hasChanges;
  final bool isSaving;
  final String? profileImagePath;

  const UpdateProfileState({
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.birthYear = '',
    this.gender = 'Male',
    this.location = '',
    this.bio = '',
    this.hasChanges = false,
    this.isSaving = false,
    this.profileImagePath,
  });

  UpdateProfileState copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? birthYear,
    String? gender,
    String? location,
    String? bio,
    bool? hasChanges,
    bool? isSaving,
    String? profileImagePath,
  }) {
    return UpdateProfileState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthYear: birthYear ?? this.birthYear,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      hasChanges: hasChanges ?? this.hasChanges,
      isSaving: isSaving ?? this.isSaving,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        phoneNumber,
        birthYear,
        gender,
        location,
        bio,
        hasChanges,
        isSaving,
        profileImagePath,
      ];
}
