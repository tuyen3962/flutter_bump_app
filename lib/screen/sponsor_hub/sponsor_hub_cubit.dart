import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/privy_wallet_service.dart';
import 'package:flutter_bump_app/data/repository/bid/ibid_repository.dart';

import 'sponsor_hub_state.dart';

class SponsorHubCubit extends BaseCubit<SponsorHubState> {
  final IBidRepository bidRepository;
  final AccountService accountService;
  final PrivyWalletService privyWalletService;

  SponsorHubCubit(
      this.bidRepository, this.accountService, this.privyWalletService)
      : super(
          const SponsorHubState(
              // creators: [
              //   {
              //     'id': 'c1',
              //     'name': '@hodl_master',
              //     'avatar': '🚀',
              //     'topics': 'Bitcoin, Web3, Lifestyle',
              //     'followers': 89,
              //     'totalViews': 62,
              //     'sponsorships': 18,
              //     'rating': 4.7,
              //     'minBid': 1.2,
              //     'blockEndsIn': '8d 14h',
              //     'hasMusic': false,
              //   },
              // ],
              // wonAuctions: [
              //   {
              //     'id': 'c2',
              //     'name': '@cryptoqueen_',
              //     'avatar': '👑',
              //     'topics': 'DeFi, NFTs, Trading',
              //     'winningBid': 1.6,
              //   },
              //   {
              //     'id': 'c3',
              //     'name': '@nft_ninja',
              //     'avatar': '⚡',
              //     'topics': 'NFTs, Gaming, Metaverse',
              //     'winningBid': 2.6,
              //   },
              // ],
              // sponsorships: [
              //   {
              //     'creator': '@cryptoqueen_',
              //     'budget': 2.5,
              //     'status': 'completed',
              //     'duration': 'Oct 6 → Oct 20',
              //     'hasYoutube': true,
              //     'hasTiktok': true,
              //   },
              //   {
              //     'creator': '@hodl_master',
              //     'budget': 1.8,
              //     'status': 'in_progress',
              //     'duration': 'Oct 10 → Oct 24',
              //     'hasYoutube': true,
              //     'hasTiktok': false,
              //   },
              // ],
              ),
        );

  void selectTab(SelectedTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }

  // void placeBid(String creatorId, double bidAmount) {
  //   final newUserBids = Map<String, double>.from(state.userBids);
  //   newUserBids[creatorId] = bidAmount;

  //   final newHighestBids = Map<String, double>.from(state.highestBids);
  //   newHighestBids[creatorId] = bidAmount;

  //   emit(state.copyWith(
  //     userBids: newUserBids,
  //     highestBids: newHighestBids,
  //     walletBalance: state.walletBalance - bidAmount,
  //     totalSpent: state.totalSpent + bidAmount,
  //   ));
  // }

  // void increaseBid(String creatorId, double additionalAmount) {
  //   final currentBid = state.userBids[creatorId] ?? 0;
  //   final newBidAmount = currentBid + additionalAmount;

  //   final newUserBids = Map<String, double>.from(state.userBids);
  //   newUserBids[creatorId] = newBidAmount;

  //   final newHighestBids = Map<String, double>.from(state.highestBids);
  //   newHighestBids[creatorId] = newBidAmount;

  //   emit(state.copyWith(
  //     userBids: newUserBids,
  //     highestBids: newHighestBids,
  //     walletBalance: state.walletBalance - additionalAmount,
  //     totalSpent: state.totalSpent + additionalAmount,
  //   ));
  // }

  // void selectSponsorshipFilter(String filter) {
  //   emit(state.copyWith(sponsorshipFilter: filter));
  // }
}
