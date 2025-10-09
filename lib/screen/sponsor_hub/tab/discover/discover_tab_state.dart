import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum DiscoverTabFilter { all, bidding, unbid, my_bid }

extension DiscoverTabFilterExtension on DiscoverTabFilter {
  String get title {
    switch (this) {
      case DiscoverTabFilter.all:
        return 'All';
      case DiscoverTabFilter.bidding:
        return 'Bidding';
      case DiscoverTabFilter.unbid:
        return 'No Bid';
      case DiscoverTabFilter.my_bid:
        return 'My Bid';
    }
  }
}

class DiscoverTabState extends BaseState {
  final DiscoverTabFilter filter;
  final double walletBalance;

  // final List<BidModel> creators;

  const DiscoverTabState({
    this.filter = DiscoverTabFilter.all,
    super.isLoading = false,
    this.walletBalance = 0,
    // this.creators = const [],
  });

  DiscoverTabState copyWith({
    DiscoverTabFilter? filter,
    bool? isLoading,
    double? walletBalance,
    // List<BidModel>? creators,
  }) {
    return DiscoverTabState(
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      walletBalance: walletBalance ?? this.walletBalance,
      // creators: creators ?? this.creators,
    );
  }

  @override
  List<Object?> get props => [filter, isLoading, walletBalance];
}
