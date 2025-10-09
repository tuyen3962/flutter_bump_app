import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class SponsorHubState extends BaseState {
  // final double walletBalance;
  // final double totalSpent;
  final SelectedTab selectedTab;
  // final int wonAuctionsCount;
  // final List<Map<String, dynamic>> creators;
  // final Map<String, double> userBids;
  // final Map<String, double> highestBids;
  // final List<Map<String, dynamic>> wonAuctions;
  // final List<Map<String, dynamic>> sponsorships;
  // final String sponsorshipFilter;

  const SponsorHubState({
    // this.walletBalance = 10.9,
    // this.totalSpent = 47.8,
    this.selectedTab = SelectedTab.discover,
    // this.wonAuctionsCount = 2,
    // this.creators = const [],
    // this.userBids = const {},
    // this.highestBids = const {},
    // this.wonAuctions = const [],
    // this.sponsorships = const [],
    // this.sponsorshipFilter = 'all',
  });

  SponsorHubState copyWith({
    // double? walletBalance,
    // double? totalSpent,
    SelectedTab? selectedTab,
    // int? wonAuctionsCount,
    // List<Map<String, dynamic>>? creators,
    // Map<String, double>? userBids,
    // Map<String, double>? highestBids,
    // List<Map<String, dynamic>>? wonAuctions,
    // List<Map<String, dynamic>>? sponsorships,
    // String? sponsorshipFilter,
  }) {
    return SponsorHubState(
      // walletBalance: walletBalance ?? this.walletBalance,
      // totalSpent: totalSpent ?? this.totalSpent,
      selectedTab: selectedTab ?? this.selectedTab,
      //   wonAuctionsCount: wonAuctionsCount ?? this.wonAuctionsCount,
      //   creators: creators ?? this.creators,
      //   userBids: userBids ?? this.userBids,
      //   highestBids: highestBids ?? this.highestBids,
      //   wonAuctions: wonAuctions ?? this.wonAuctions,
      //   sponsorships: sponsorships ?? this.sponsorships,
      // sponsorshipFilter: sponsorshipFilter ?? this.sponsorshipFilter,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        // walletBalance,
        // totalSpent,
        selectedTab,
        // wonAuctionsCount,
        // creators,
        // userBids,
        // highestBids,
        // wonAuctions,
        // sponsorships,
        // sponsorshipFilter,
      ];
}

enum SelectedTab { discover, sponsorships }
