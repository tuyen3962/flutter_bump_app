import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/config/service/privy_wallet_service.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/data/model/creator_model.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';

class InlineBidForm extends StatefulWidget {
  const InlineBidForm({
    super.key,
    required this.creator,
    this.cancelBid,
    this.confirmBid,
  });

  final CreatorModel creator;
  final VoidCallback? cancelBid;
  final Function(double amount)? confirmBid;

  @override
  State<InlineBidForm> createState() => _InlineBidFormState();
}

class _InlineBidFormState extends State<InlineBidForm> {
  final PrivyWalletService privyWalletService = locator<PrivyWalletService>();

  final TextEditingController bidController = TextEditingController();

  CreatorModel get creator => widget.creator;

  double bidAmount = 0;
  double minimumRequired = 0;

  @override
  void initState() {
    super.initState();
    bidAmount = creator.minBid ?? 0;
    minimumRequired = (creator.minBid ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding(all: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF374151).withSafeOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Min: ${creator.minBid?.toStringAsFixed(1)} SOL',
                style: AppStyle.regular12(color: Colors.white60),
              ),
              Text(
                // 'Balance: ${state.walletBalance.toStringAsFixed(2)} SOL',
                '',
                style: AppStyle.regular12(color: Colors.white60),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF374151),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: bidController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: AppStyle.bold16(color: appTheme.whiteText),
              textAlign: TextAlign.center,
              onChanged: (value) {
                // cubit.updateBidAmount(double.tryParse(value) ?? 0);
              },
              decoration: InputDecoration(
                hintText: creator.minBid?.toStringAsFixed(1) ?? '0',
                hintStyle: AppStyle.regular14(color: Colors.white38),
                suffixText: 'SOL',
                suffixStyle: AppStyle.medium12(color: Colors.white60),
                border: InputBorder.none,
                contentPadding: padding(all: 12.w),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildQuickBidButton('+0.1', () {
                  bidAmount += 0.1;
                  bidController.text = bidAmount.toStringAsFixed(1);
                  setState(() {});
                }),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildQuickBidButton('+20%', () {
                  bidAmount += bidAmount * 0.2;
                  bidController.text = bidAmount.toStringAsFixed(1);
                  setState(() {});
                }),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildQuickBidButton('+50%', () {
                  bidAmount += bidAmount * 0.5;
                  bidController.text = bidAmount.toStringAsFixed(1);
                  setState(() {});
                }),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: privyWalletService.solanaBalance,
                    builder: (context, value, __) {
                      return SizedBox(
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: bidAmount >= minimumRequired &&
                                  bidAmount <= value.balanceSol
                              ? () {
                                  widget.confirmBid?.call(bidAmount);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appTheme.transparentColor,
                            disabledBackgroundColor: Colors.grey.shade800,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: bidAmount >= minimumRequired &&
                                      bidAmount < value.balanceSol
                                  ? LinearGradient(
                                      colors: [
                                        appTheme.green4AColor,
                                        appTheme.green69Color,
                                      ],
                                    )
                                  : null,
                              color: bidAmount >= minimumRequired &&
                                      bidAmount < value.balanceSol
                                  ? null
                                  : Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: bidAmount >= minimumRequired &&
                                            bidAmount <= value.balanceSol
                                        ? const Color(0xFF0F172A)
                                        : Colors.white38,
                                    size: 16.w,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Confirm Bid',
                                    style: AppStyle.bold12(
                                      color: bidAmount >= minimumRequired &&
                                              bidAmount <= value.balanceSol
                                          ? const Color(0xFF0F172A)
                                          : Colors.white38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    // cubit.updateBidAmount(0);
                    widget.cancelBid?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF374151),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: padding(horizontal: 16.w),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppStyle.medium12(color: appTheme.whiteText),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickBidButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding(vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF374151),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.white.withSafeOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppStyle.medium10(color: appTheme.whiteText),
          ),
        ),
      ),
    );
  }
}
