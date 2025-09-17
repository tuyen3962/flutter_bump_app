import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class DashboardState extends BaseState {
  final String? errorMessage;
  final dynamic data; // Replace with your specific data type

  const DashboardState({
    this.errorMessage,
    this.data,
    super.isLoading = false,
  });

  DashboardState copyWith({
    bool? isLoading,
    String? errorMessage,
    dynamic data, // Replace with your specific data type
  }) {
    return DashboardState(
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
