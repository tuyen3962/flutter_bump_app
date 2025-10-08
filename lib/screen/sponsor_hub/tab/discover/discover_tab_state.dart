import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum DiscoverTabFilter { all, bidding, unbid, my_bid }

class DiscoverTabState extends BaseState {
  final DiscoverTabFilter filter;
  // final List<BidModel> creators;

  const DiscoverTabState({
    this.filter = DiscoverTabFilter.all,
    super.isLoading = false,
    // this.creators = const [],
  });

  DiscoverTabState copyWith({
    DiscoverTabFilter? filter,
    bool? isLoading,
    // List<BidModel>? creators,
  }) {
    return DiscoverTabState(
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      // creators: creators ?? this.creators,
    );
  }

  @override
  List<Object?> get props => [filter, isLoading];
}
