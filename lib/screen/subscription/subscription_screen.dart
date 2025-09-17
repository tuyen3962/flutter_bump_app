import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/screen/subscription/subscription_cubit.dart';

import 'subscription_state.dart';

@RoutePage()
class SubscriptionPage extends BaseBlocProvider<SubscriptionState, SubscriptionCubit> {
  const SubscriptionPage({super.key});

  @override
  Widget buildPage() {
    return const SubscriptionScreen();
  }

  @override
  SubscriptionCubit createCubit() {
    return SubscriptionCubit();
  }
}

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => SubscriptionScreenState();
}

class SubscriptionScreenState
    extends BaseBlocNoAppBarPageState<SubscriptionScreen, SubscriptionState, SubscriptionCubit> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.initializeSubscription();
    });
  }

  @override
  String get title => 'Subscription';

  @override
  Widget buildBody(BuildContext context, SubscriptionCubit cubit) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        if (state.isLoading && state.availablePlans.isEmpty) {
          return Scaffold(
            backgroundColor: appTheme.gray50,
            body: Center(
              child: CircularProgressIndicator(
                color: appTheme.blue500,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: appTheme.gray50,
          body: Column(
            children: [
              // Header
              _buildHeader(state),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Current Subscription Status
                      _buildCurrentStatus(state),

                      SizedBox(height: 24.h),

                      // Billing Cycle Toggle
                      _buildBillingCycleToggle(state),

                      SizedBox(height: 24.h),

                      // Available Plans
                      _buildAvailablePlans(state),

                      SizedBox(height: 24.h),

                      // Actions Section
                      _buildActionsSection(state),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(SubscriptionState state) {
    return Container(
      padding: padding(all: 16),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        border: Border(
          bottom: BorderSide(color: appTheme.gray200, width: 1),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.back(),
              child: Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: appTheme.transparentColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: appTheme.gray600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Manage Subscription',
                style: AppStyle.bold18(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 32.w), // Spacer
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStatus(SubscriptionState state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: padding(all: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            appTheme.blue50,
            Color(0xFFF3E8FF),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: appTheme.gray300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Plan',
                style: AppStyle.bold18(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF3E8FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  state.currentPlanName,
                  style: AppStyle.medium14(color: Color(0xFF7C3AED)),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            state.getCurrentPlanInfo()?.description ?? 'Professional plan with all features',
            style: AppStyle.regular14(color: appTheme.gray600),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: AppStyle.regular12(color: appTheme.gray500),
                    ),
                    Text(
                      state.statusText,
                      style: AppStyle.medium14(
                        color: state.isSubscriptionActive ? appTheme.green600 : appTheme.red600,
                      ),
                    ),
                  ],
                ),
              ),
              if (state.subscriptionEndDate != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.autoRenew ? 'Renews on' : 'Expires on',
                        style: AppStyle.regular12(color: appTheme.gray500),
                      ),
                      Text(
                        cubit.formatDate(state.subscriptionEndDate!),
                        style: AppStyle.medium14(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (state.currentPlan != SubscriptionPlan.free) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Billing',
                        style: AppStyle.regular12(color: appTheme.gray500),
                      ),
                      Text(
                        state.currentBillingCycle == BillingCycle.monthly ? 'Monthly' : 'Yearly',
                        style: AppStyle.medium14(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto Renew',
                        style: AppStyle.regular12(color: appTheme.gray500),
                      ),
                      Text(
                        state.autoRenew ? 'Enabled' : 'Disabled',
                        style: AppStyle.medium14(
                          color: state.autoRenew ? appTheme.green600 : appTheme.amber600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBillingCycleToggle(SubscriptionState state) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: padding(all: 4),
      decoration: BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => cubit.selectBillingCycle(BillingCycle.monthly),
              child: Container(
                padding: padding(vertical: 12),
                decoration: BoxDecoration(
                  color:
                      state.selectedBillingCycle == BillingCycle.monthly ? appTheme.alpha : appTheme.transparentColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: state.selectedBillingCycle == BillingCycle.monthly
                      ? [
                          BoxShadow(
                            color: appTheme.gray200.withSafeOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  'Monthly',
                  style: AppStyle.medium14(
                    color: state.selectedBillingCycle == BillingCycle.monthly ? appTheme.blue600 : appTheme.gray600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => cubit.selectBillingCycle(BillingCycle.yearly),
              child: Container(
                padding: padding(vertical: 12),
                decoration: BoxDecoration(
                  color: state.selectedBillingCycle == BillingCycle.yearly ? appTheme.alpha : appTheme.transparentColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: state.selectedBillingCycle == BillingCycle.yearly
                      ? [
                          BoxShadow(
                            color: appTheme.gray200.withSafeOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  children: [
                    Text(
                      'Yearly',
                      style: AppStyle.medium14(
                        color: state.selectedBillingCycle == BillingCycle.yearly ? appTheme.blue600 : appTheme.gray600,
                      ),
                    ),
                    if (state.selectedBillingCycle == BillingCycle.yearly && state.yearlySavingsPercentage > 0)
                      Text(
                        'Save ${state.yearlySavingsPercentage.round()}%',
                        style: AppStyle.regular10(color: appTheme.green600),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailablePlans(SubscriptionState state) {
    return Column(
      children: state.availablePlans.map((planInfo) {
        final isCurrentPlan = planInfo.plan == state.currentPlan;
        final isSelected = planInfo.plan == state.selectedPlan;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: appTheme.alpha,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? appTheme.blue500 : appTheme.gray200,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: planInfo.isPopular || isSelected
                ? [
                    BoxShadow(
                      color: appTheme.blue200.withSafeOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Stack(
            children: [
              // Popular badge
              if (planInfo.isPopular)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: appTheme.blue500,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Most Popular',
                      style: AppStyle.medium12(color: appTheme.alpha),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

              // Plan content
              Padding(
                padding: padding(all: 20).add(
                  EdgeInsets.only(top: planInfo.isPopular ? 32.h : 0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  planInfo.name,
                                  style: AppStyle.bold20(),
                                ),
                                if (isCurrentPlan) ...[
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: appTheme.green100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Current',
                                      style: AppStyle.regular10(color: appTheme.green800),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              planInfo.description,
                              style: AppStyle.regular14(color: appTheme.gray600),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (planInfo.plan != SubscriptionPlan.free) ...[
                              Text(
                                planInfo.getPriceText(state.selectedBillingCycle),
                                style: AppStyle.bold18(color: appTheme.blue600),
                              ),
                              if (state.selectedBillingCycle == BillingCycle.yearly)
                                Text(
                                  '${cubit.formatPrice(planInfo.monthlyPrice)}/month billed yearly',
                                  style: AppStyle.regular12(color: appTheme.gray500),
                                ),
                            ] else
                              Text(
                                'Free',
                                style: AppStyle.bold18(color: appTheme.green600),
                              ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Features list
                    ...planInfo.features.take(3).map((feature) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            Icon(
                              feature.isIncluded ? Icons.check_circle : Icons.cancel,
                              size: 16,
                              color: feature.isIncluded ? appTheme.green500 : appTheme.gray300,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                feature.title,
                                style: AppStyle.regular14(
                                  color: feature.isIncluded ? appTheme.gray900 : appTheme.gray400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    if (planInfo.features.length > 3) ...[
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () => _showAllFeatures(planInfo),
                        child: Text(
                          'View all features',
                          style: AppStyle.medium14(color: appTheme.blue600),
                        ),
                      ),
                    ],

                    SizedBox(height: 16.h),

                    // Action button
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: isCurrentPlan
                            ? null
                            : () {
                                cubit.selectPlan(planInfo.plan);
                                if (planInfo.plan != state.currentPlan) {
                                  _showUpgradeDialog(planInfo, state);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isCurrentPlan ? appTheme.gray200 : (isSelected ? appTheme.blue500 : appTheme.blue100),
                          foregroundColor:
                              isCurrentPlan ? appTheme.gray500 : (isSelected ? appTheme.alpha : appTheme.blue600),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          isCurrentPlan
                              ? 'Current Plan'
                              : (cubit.isPlanUpgrade(planInfo.plan)
                                  ? 'Upgrade'
                                  : cubit.isPlanDowngrade(planInfo.plan)
                                      ? 'Downgrade'
                                      : 'Select'),
                          style: AppStyle.medium16(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionsSection(SubscriptionState state) {
    if (state.currentPlan == SubscriptionPlan.free) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: padding(all: 20),
      decoration: BoxDecoration(
        color: appTheme.alpha,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: appTheme.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subscription Actions',
            style: AppStyle.bold16(),
          ),
          SizedBox(height: 16.h),
          if (state.autoRenew)
            _buildActionTile(
              icon: Icons.pause_circle_outline,
              title: 'Cancel Subscription',
              subtitle:
                  'Cancel auto-renewal, access until ${state.subscriptionEndDate != null ? cubit.formatDate(state.subscriptionEndDate!) : "end of period"}',
              onTap: () => _showCancelDialog(),
            )
          else
            _buildActionTile(
              icon: Icons.play_circle_outline,
              title: 'Reactivate Subscription',
              subtitle: 'Resume auto-renewal',
              onTap: () => _showReactivateDialog(),
            ),
          _buildActionTile(
            icon: Icons.restore,
            title: 'Restore Purchases',
            subtitle: 'Restore purchases from App Store or Google Play',
            onTap: () => _restorePurchases(),
          ),
        ],
      ),
    );
  }

  // _showAllFeatures method
  void _showAllFeatures(SubscriptionPlanInfo planInfo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: appTheme.alpha,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: padding(all: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: appTheme.gray300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  margin: EdgeInsets.only(bottom: 16.h),
                ),
              ),
              Text(
                '${planInfo.name} Features',
                style: AppStyle.bold18(),
              ),
              SizedBox(height: 16.h),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: planInfo.features.length,
                  itemBuilder: (context, index) {
                    final feature = planInfo.features[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            feature.isIncluded ? Icons.check_circle : Icons.cancel,
                            size: 20,
                            color: feature.isIncluded ? appTheme.green500 : appTheme.gray300,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  feature.title,
                                  style: AppStyle.medium14(
                                    color: feature.isIncluded ? appTheme.gray900 : appTheme.gray400,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  feature.description,
                                  style: AppStyle.regular12(color: appTheme.gray500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// _showUpgradeDialog method
  void _showUpgradeDialog(SubscriptionPlanInfo planInfo, SubscriptionState state) {
    final isUpgrade = cubit.isPlanUpgrade(planInfo.plan);
    final actionText = isUpgrade ? 'Upgrade' : 'Change';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$actionText to ${planInfo.name}', style: AppStyle.bold18()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You will be charged ${planInfo.getPriceText(state.selectedBillingCycle)} and your plan will change immediately.',
              style: AppStyle.regular16(),
            ),
            if (state.selectedBillingCycle == BillingCycle.yearly && state.yearlySavingsPercentage > 0) ...[
              SizedBox(height: 8.h),
              Text(
                'Save ${state.yearlySavingsPercentage.round()}% with yearly billing!',
                style: AppStyle.medium14(color: appTheme.green600),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppStyle.medium14(color: appTheme.gray600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await cubit.subscribeToPlan();
              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Successfully ${actionText.toLowerCase()}d to ${planInfo.name}!'),
                    backgroundColor: appTheme.green500,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                );
              } else if (!success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to ${actionText.toLowerCase()}. Please try again.'),
                    backgroundColor: appTheme.red500,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                );
              }
            },
            child: Text(actionText, style: AppStyle.medium14(color: appTheme.blue500)),
          ),
        ],
      ),
    );
  }

// _buildActionTile method
  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: appTheme.gray600),
      title: Text(title, style: AppStyle.medium16()),
      subtitle: Text(subtitle, style: AppStyle.regular14(color: appTheme.gray500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: appTheme.gray400),
      onTap: onTap,
    );
  }

// _showCancelDialog method
  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Subscription', style: AppStyle.bold18()),
        content: Text(
          'Your subscription will remain active until the end of the current billing period. You can reactivate anytime.',
          style: AppStyle.regular16(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Keep Subscription', style: AppStyle.medium14(color: appTheme.gray600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await cubit.cancelSubscription();
              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Subscription cancelled successfully'),
                    backgroundColor: appTheme.green500,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                );
              } else if (!success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to cancel subscription. Please try again.'),
                    backgroundColor: appTheme.red500,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                );
              }
            },
            child: Text('Cancel', style: AppStyle.medium14(color: appTheme.red500)),
          ),
        ],
      ),
    );
  }

// _showReactivateDialog method
  void _showReactivateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reactivate Subscription', style: AppStyle.bold18()),
        content: Text(
          'Your subscription will resume and auto-renew at the end of the current period.',
          style: AppStyle.regular16(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppStyle.medium14(color: appTheme.gray600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await cubit.reactivateSubscription();
              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Subscription reactivated successfully'),
                    backgroundColor: appTheme.green500,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                );
              } else if (!success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to reactivate subscription. Please try again.'),
                    backgroundColor: appTheme.red500,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                );
              }
            },
            child: Text('Reactivate', style: AppStyle.medium14(color: appTheme.blue500)),
          ),
        ],
      ),
    );
  }

// _restorePurchases method
  void _restorePurchases() async {
    // Show loading state
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 16.w,
              height: 16.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(appTheme.alpha),
              ),
            ),
            SizedBox(width: 12.w),
            Text('Restoring purchases...'),
          ],
        ),
        backgroundColor: appTheme.blue500,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 10),
      ),
    );

    await cubit.restorePurchases();

    if (mounted) {
      // Clear any existing snackbar
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Purchases restored successfully'),
          backgroundColor: appTheme.green500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
    }
  }
}
