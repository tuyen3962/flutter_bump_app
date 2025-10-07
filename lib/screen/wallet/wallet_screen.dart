import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/wallet/wallet_cubit.dart';
import 'package:flutter_bump_app/screen/wallet/wallet_state.dart';

@RoutePage()
class WalletPage extends BaseBlocProvider<WalletState, WalletCubit> {
  const WalletPage({super.key});

  @override
  Widget buildPage() {
    return const WalletScreen();
  }

  @override
  WalletCubit createCubit() {
    return WalletCubit();
  }
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => WalletScreenState();
}

class WalletScreenState
    extends BaseBlocNoAppBarPageState<WalletScreen, WalletState, WalletCubit> {
  @override
  bool get isSafeArea => false;

  @override
  Widget buildBody(BuildContext context, WalletCubit cubit) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0F172A),
                Color(0xFF1E293B),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: padding(all: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBalanceCard(state, cubit),
                        SizedBox(height: 24.h),
                        _buildRecentTransactions(state),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: padding(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.back(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white.withSafeOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: appTheme.whiteText,
                size: 20.w,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Wallet',
            style: AppStyle.bold20(color: appTheme.whiteText),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(WalletState state, WalletCubit cubit) {
    return Container(
      width: double.infinity,
      padding: padding(all: 32.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2D4A3E),
            Color(0xFF1A2E24),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: appTheme.green4AColor.withSafeOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Available Balance',
            style: AppStyle.regular16(color: Colors.white70),
          ),
          SizedBox(height: 12.h),
          Text(
            '${state.balance.toStringAsFixed(4)} SOL',
            style: AppStyle.bold32(color: appTheme.whiteText),
          ),
          SizedBox(height: 8.h),
          Text(
            '≈ \$${state.balanceUSD.toStringAsFixed(2)} USD',
            style: AppStyle.regular14(color: Colors.white60),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      _showAddFundsDialog(cubit, state);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appTheme.transparentColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            appTheme.green4AColor,
                            appTheme.green69Color,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: const Color(0xFF0F172A),
                              size: 20.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Add Funds',
                              style: AppStyle.bold14(
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Show history
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E293B),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: appTheme.whiteText,
                          size: 20.w,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'History',
                          style: AppStyle.bold14(color: appTheme.whiteText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions(WalletState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: AppStyle.bold18(color: appTheme.whiteText),
        ),
        SizedBox(height: 16.h),
        ...state.transactions.map((tx) => _buildTransactionCard(tx)),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> tx) {
    final isPositive = tx['amount'] > 0;
    final String type = tx['type'];
    Color iconColor;
    IconData icon;

    if (type == 'add') {
      iconColor = const Color(0xFF22C55E);
      icon = Icons.trending_up;
    } else {
      iconColor = appTheme.green4AColor;
      icon = Icons.attach_money;
    }

    return Container(
      margin: padding(bottom: 12.h),
      padding: padding(all: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withSafeOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: iconColor.withSafeOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['title'],
                  style: AppStyle.bold14(color: appTheme.whiteText),
                ),
                SizedBox(height: 4.h),
                Text(
                  tx['time'],
                  style: AppStyle.regular12(color: Colors.white60),
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : ''}${tx['amount'].toStringAsFixed(1)} SOL',
            style: AppStyle.bold16(
              color:
                  isPositive ? const Color(0xFF22C55E) : appTheme.green4AColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddFundsDialog(WalletCubit cubit, WalletState state) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: padding(all: 24.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1E293B),
                  Color(0xFF0F172A),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withSafeOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Funds',
                  style: AppStyle.bold20(color: appTheme.whiteText),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Quick Add',
                  style: AppStyle.regular14(color: Colors.white60),
                ),
                SizedBox(height: 16.h),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: [5.0, 10.0, 20.0, 50.0].map((amount) {
                    return GestureDetector(
                      onTap: () {
                        cubit.addFunds(amount);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '💰 Added ${amount.toStringAsFixed(1)} SOL to wallet!',
                              style: AppStyle.medium14(
                                color: appTheme.whiteText,
                              ),
                            ),
                            backgroundColor: appTheme.green4AColor,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: padding(horizontal: 20.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF374151),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withSafeOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '+${amount.toStringAsFixed(0)} SOL',
                          style: AppStyle.bold14(color: appTheme.whiteText),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF374151),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: AppStyle.bold14(color: appTheme.whiteText),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
