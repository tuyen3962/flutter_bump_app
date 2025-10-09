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
  final double bidAmount;
  final String creatorId;
  final int countdowns;
  // final List<BidModel> creators;

  final String biddingCreatorId;

  const DiscoverTabState({
    this.filter = DiscoverTabFilter.all,
    super.isLoading = false,
    this.bidAmount = 0,
    this.creatorId = '',
    this.countdowns = 0,
    this.biddingCreatorId = '',
    // this.creators = const [],
  });

  DiscoverTabState copyWith({
    DiscoverTabFilter? filter,
    bool? isLoading,
    double? bidAmount,
    String? creatorId,
    int? countdowns,
    String? biddingCreatorId,
    // List<BidModel>? creators,
  }) {
    return DiscoverTabState(
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      bidAmount: bidAmount ?? this.bidAmount,
      creatorId: creatorId ?? this.creatorId,
      countdowns: countdowns ?? this.countdowns,
      biddingCreatorId: biddingCreatorId ?? this.biddingCreatorId,
      // creators: creators ?? this.creators,
    );
  }

  @override
  List<Object?> get props => [
        filter,
        isLoading,
        bidAmount,
        creatorId,
        countdowns,
        biddingCreatorId,
      ];
}
