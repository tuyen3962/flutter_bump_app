import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class ProfileState extends BaseState {
  final String? errorMessage;
  final dynamic data; // Replace with your specific data type

  const ProfileState({
    this.errorMessage,
    this.data,
    super.isLoading = false,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    dynamic data, // Replace with your specific data type
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        data,
      ];
}
