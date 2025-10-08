import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/data/repository/bid/ibid_repository.dart';

import 'discover_tab_state.dart';

class DiscoverTabCubit extends BaseCubit<DiscoverTabState> {
  final IBidRepository bidRepository;

  DiscoverTabCubit({
    required this.bidRepository,
  }) : super(const DiscoverTabState());

  // late final LazyListController<BidModel> creatorCtrl = LazyListController(
  //     onLoad: (page) =>
  //         bidRepository.getAllCreatorBids(limit: LIMIT, page: page),
  //     limit: LIMIT);

  @override
  Future<void> close() {
    // creatorCtrl.dispose();
    return super.close();
  }

  void changeFilter(DiscoverTabFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}
