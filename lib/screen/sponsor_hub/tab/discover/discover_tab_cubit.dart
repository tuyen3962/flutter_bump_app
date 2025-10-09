import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/data/model/creator_model.dart';
import 'package:flutter_bump_app/data/repository/bid/ibid_repository.dart';
import 'package:flutter_bump_app/utils/lazy_list/lazy_list_controller.dart';

import 'discover_tab_state.dart';

class DiscoverTabCubit extends BaseCubit<DiscoverTabState> {
  final IBidRepository bidRepository;

  DiscoverTabCubit({
    required this.bidRepository,
  }) : super(const DiscoverTabState()) {
    init();
  }

  late final LazyListController<CreatorModel> allBidsListCtrl;
  late final LazyListController<CreatorModel> biddingBidsListCtrl;
  late final LazyListController<CreatorModel> noBidListCtrl;
  late final LazyListController<CreatorModel> myBidListCtrl;

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
    return super.close();
  }

  void placeBid(String creatorId, double bidAmount) {
    emit(state.copyWith(
      walletBalance: state.walletBalance - bidAmount,
    ));
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
}
