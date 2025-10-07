import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/screen/discover_detail/discover_detail_parameter.dart';

import 'discover_detail_state.dart';

class DiscoverDetailCubit extends BaseCubit<DiscoverDetailState> {
  late final AccountService accountService = locator.get();
  final DiscoverDetailParameter parameter;

  DiscoverDetailCubit({
    required this.parameter,
  }) : super(const DiscoverDetailState()) {
    _loadCreatorData();
  }

  void _loadCreatorData() {
    // Load specific data based on creator
    if (parameter.creator['id'] == 'c2') {
      emit(state.copyWith(
        description:
            'Crypto enthusiast creating viral content about DeFi, NFTs and trading strategies. Known for making complex topics accessible to everyone! 🚀💎',
        tokenContract: 'CRYPTOqeeN...x8k2',
        tokenPrice: '0.0012',
        volume24h: '12.4K',
        marketCap: '847K',
        holders: '2,847',
      ));
    } else if (parameter.creator['id'] == 'c3') {
      emit(state.copyWith(
        description:
            'NFT collector and gaming enthusiast exploring the metaverse. Creating content that bridges traditional gaming with Web3! 🎮⚡',
        tokenContract: 'NFTninja99...m3l5',
        tokenPrice: '0.0024',
        volume24h: '24.8K',
        marketCap: '1.2M',
        holders: '4,521',
      ));
    } else {
      emit(state.copyWith(
        description:
            'Bitcoin maximalist sharing lifestyle content and Web3 insights. Building the future one video at a time! ₿✨',
        tokenContract: 'HODLmastr...7j9w',
        tokenPrice: '0.0008',
        volume24h: '8.9K',
        marketCap: '512K',
        holders: '1,847',
      ));
    }
  }
}
