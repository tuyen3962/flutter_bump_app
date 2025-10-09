import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  late final AccountService accountService = locator.get();

  WalletCubit()
      : super(
          const WalletState(
            transactions: [
              {
                'title': '@cryptoqueen_', 
                'time': '2h ago',
                'amount': -2.5,
                'type': 'spend',
              },
              {
                'title': '@hodl_master',
                'time': '1d ago',
                'amount': -1.8,
                'type': 'spend',
              },
              {
                'title': 'Funds added',
                'time': '2d ago',
                'amount': 10.0,
                'type': 'add',
              },
              {
                'title': '@nft_ninja',
                'time': '1w ago',
                'amount': -3.2,
                'type': 'spend',
              },
            ],
          ),
        );

  void addFunds(double amount) {
    final newBalance = state.balance + amount;
    final newBalanceUSD = newBalance * 142.5;

    final newTransactions = [
      {
        'title': 'Funds added',
        'time': 'Just now',
        'amount': amount,
        'type': 'add',
      },
      ...state.transactions,
    ];

    emit(state.copyWith(
      balance: newBalance,
      balanceUSD: newBalanceUSD,
      transactions: newTransactions,
    ));
  }

  void addTransaction(String title, double amount, String type) {
    final newBalance = state.balance + amount;
    final newBalanceUSD = newBalance * 142.5;

    final newTransactions = [
      {
        'title': title,
        'time': 'Just now',
        'amount': amount,
        'type': type,
      },
      ...state.transactions,
    ];

    emit(state.copyWith(
      balance: newBalance,
      balanceUSD: newBalanceUSD,
      transactions: newTransactions,
    ));
  }
}
