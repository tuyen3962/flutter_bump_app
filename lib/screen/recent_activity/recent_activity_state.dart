import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class RecentActivityState extends BaseState {
  final String? errorMessage;
  final dynamic data; // Replace with your specific data type

  const RecentActivityState({
    this.errorMessage,
    this.data,
    super.isLoading = false,
  });

  RecentActivityState copyWith({
    bool? isLoading,
    String? errorMessage,
    dynamic data, // Replace with your specific data type
  }) {
    return RecentActivityState(
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
