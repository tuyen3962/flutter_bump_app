import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/config/service/privy_wallet_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/data/model/creator_model.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_request.dart';
import 'package:flutter_bump_app/data/repository/bid/ibid_repository.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/utils/lazy_list/lazy_list_controller.dart';
import 'package:flutter_bump_app/utils/loading.dart';

import 'discover_tab_state.dart';

class DiscoverTabCubit extends BaseCubit<DiscoverTabState> {
  final IBidRepository bidRepository;
  final PrivyWalletService privyWalletService;

  DiscoverTabCubit({
    required this.bidRepository,
    required this.privyWalletService,
  }) : super(const DiscoverTabState()) {
    init();
  }

  late final LazyListController<CreatorModel> allBidsListCtrl;
  late final LazyListController<CreatorModel> biddingBidsListCtrl;
  late final LazyListController<CreatorModel> noBidListCtrl;
  late final LazyListController<CreatorModel> myBidListCtrl;

  Timer? _countdownTimer;

  void init() {
    allBidsListCtrl = LazyListController(
      onLoad: (page) async {
        final res = await bidRepository.getAllBids(limit: LIMIT, page: page);

        return res.data!;
      },
      limit: LIMIT,
    );

    biddingBidsListCtrl = LazyListController(
      onLoad: (page) async {
        final res =
            await bidRepository.getBiddingBids(limit: LIMIT, page: page);

        return res.data!;
      },
      limit: LIMIT,
    );

    noBidListCtrl = LazyListController(
      onLoad: (page) async {
        final res = await bidRepository.getNoBidsBids(limit: LIMIT, page: page);

        return res.data!;
      },
      limit: LIMIT,
    );

    myBidListCtrl = LazyListController(
      onLoad: (page) async {
        final res = await bidRepository.getMyBids(limit: LIMIT, page: page);

        return res.data!;
      },
      limit: LIMIT,
    );
  }

  LazyListController<CreatorModel> getCurrentController() {
    switch (state.filter) {
      case DiscoverTabFilter.all:
        return allBidsListCtrl;
      case DiscoverTabFilter.bidding:
        return biddingBidsListCtrl;
      case DiscoverTabFilter.unbid:
        return noBidListCtrl;
      case DiscoverTabFilter.my_bid:
        return myBidListCtrl;
    }
  }

  @override
  Future<void> close() {
    allBidsListCtrl.dispose();
    biddingBidsListCtrl.dispose();
    noBidListCtrl.dispose();
    myBidListCtrl.dispose();
    _countdownTimer?.cancel();
    return super.close();
  }

  void changeFilter(DiscoverTabFilter filter) {
    emit(state.copyWith(filter: filter));

    if (filter == DiscoverTabFilter.my_bid) {
      myBidListCtrl.onRefresh();
    } else if (filter == DiscoverTabFilter.unbid) {
      noBidListCtrl.onRefresh();
    } else if (filter == DiscoverTabFilter.bidding) {
      biddingBidsListCtrl.onRefresh();
    } else {
      allBidsListCtrl.onRefresh();
    }
  }

  void onSearchChanged(String keyword) {
    allBidsListCtrl.keyword = keyword;
    biddingBidsListCtrl.keyword = keyword;
    noBidListCtrl.keyword = keyword;
    myBidListCtrl.keyword = keyword;

    if (state.filter == DiscoverTabFilter.my_bid) {
      myBidListCtrl.onRefresh();
    } else if (state.filter == DiscoverTabFilter.unbid) {
      noBidListCtrl.onRefresh();
    } else if (state.filter == DiscoverTabFilter.bidding) {
      biddingBidsListCtrl.onRefresh();
    } else {
      allBidsListCtrl.onRefresh();
    }
  }

  void updateBidAmount(double amount) {
    emit(state.copyWith(bidAmount: amount));
  }

  void startCountdownTimer(String creatorId) {
    emit(state.copyWith(countdowns: 15, creatorId: creatorId));
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdowns > 0) {
        emit(state.copyWith(countdowns: state.countdowns - 1));
      } else if (state.countdowns == 0) {
        _placeBid(creatorId);
        timer.cancel();
      }
    });
  }

  void _placeBid(String creatorId) async {
    try {
      showLoading();
      final resposne = await bidRepository.placeBid(
        PlaceBidRequest(creatorId: creatorId, amount: state.bidAmount),
      );

      if (resposne.creatorId.isNotEmpty) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text(
              '🎯 Bid placed! You\'re the highest bidder!',
              style: AppStyle.medium14(color: appTheme.whiteText),
            ),
            backgroundColor: appTheme.green4AColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      print('Error placing bid: $e');
    } finally {
      dismissLoading();
      emit(state.copyWith(countdowns: 0, creatorId: ''));
    }
  }
}
