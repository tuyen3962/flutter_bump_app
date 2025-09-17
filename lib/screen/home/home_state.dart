import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class HomeState extends BaseState {
  final String? errorMessage;
  final dynamic data; // Replace with your specific data type

  const HomeState({
    this.errorMessage,
    this.data,
    super.isLoading = false,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    dynamic data, // Replace with your specific data type
  }) {
    return HomeState(
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
