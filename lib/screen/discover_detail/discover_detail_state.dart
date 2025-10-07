import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class DiscoverDetailState extends BaseState {
  final String description;
  final String tokenContract;
  final String tokenPrice;
  final String volume24h;
  final String marketCap;
  final String holders;

  const DiscoverDetailState({
    this.description =
        'Crypto enthusiast creating viral content about DeFi, NFTs and trading strategies. Known for making complex topics accessible to everyone! 🚀💎',
    this.tokenContract = 'CRYPTOqeeN...x8k2',
    this.tokenPrice = '0.0012',
    this.volume24h = '12.4K',
    this.marketCap = '847K',
    this.holders = '2,847',
  });

  DiscoverDetailState copyWith({
    String? description,
    String? tokenContract,
    String? tokenPrice,
    String? volume24h,
    String? marketCap,
    String? holders,
  }) {
    return DiscoverDetailState(
      description: description ?? this.description,
      tokenContract: tokenContract ?? this.tokenContract,
      tokenPrice: tokenPrice ?? this.tokenPrice,
      volume24h: volume24h ?? this.volume24h,
      marketCap: marketCap ?? this.marketCap,
      holders: holders ?? this.holders,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        description,
        tokenContract,
        tokenPrice,
        volume24h,
        marketCap,
        holders,
      ];
}
