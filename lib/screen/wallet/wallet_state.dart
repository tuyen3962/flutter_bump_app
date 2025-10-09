import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

class WalletState extends BaseState {
  // final double balance;
  // final double balanceUSD;
  final List<Map<String, dynamic>> transactions;
  final bool isLoggedOut;

  const WalletState({
    super.isLoading = false,
    // this.balance = 4.20,
    // this.balanceUSD = 1,
    this.transactions = const [],
    this.isLoggedOut = false,
  });

  WalletState copyWith({
    // double? balance,
    double? balanceUSD,
    List<Map<String, dynamic>>? transactions,
    bool? isLoggedOut,
  }) {
    return WalletState(
      // balance: balance ?? this.balance,
      // balanceUSD: balanceUSD ?? this.balanceUSD,
      transactions: transactions ?? this.transactions,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        // balance,
        // balanceUSD,
        transactions,
        isLoggedOut,
      ];
}
