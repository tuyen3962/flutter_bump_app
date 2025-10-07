import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class WalletState extends BaseState {
  final double balance;
  final double balanceUSD;
  final List<Map<String, dynamic>> transactions;

  const WalletState({
    super.isLoading = false,
    this.balance = 4.20,
    this.balanceUSD = 1,
    this.transactions = const [],
  });

  WalletState copyWith({
    double? balance,
    double? balanceUSD,
    List<Map<String, dynamic>>? transactions,
  }) {
    return WalletState(
      balance: balance ?? this.balance,
      balanceUSD: balanceUSD ?? this.balanceUSD,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        balance,
        balanceUSD,
        transactions,
      ];
}
