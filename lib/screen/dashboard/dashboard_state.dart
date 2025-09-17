import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class DashboardState extends BaseState {
  final int currentIndex;

  const DashboardState({this.currentIndex = 0});

  @override
  List<Object?> get props => [currentIndex];

  DashboardState copyWith({int? currentIndex}) {
    return DashboardState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
