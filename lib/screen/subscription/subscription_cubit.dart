import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'subscription_state.dart';

class SubscriptionCubit extends BaseCubit<SubscriptionState> {
  late final AccountService accountService = locator.get();

  SubscriptionCubit() : super(const SubscriptionState());

  void initializeSubscription() {
    emit(state.copyWith(isLoading: true));

    // Mock available plans
    final mockPlans = [
      const SubscriptionPlanInfo(
        plan: SubscriptionPlan.free,
        name: 'Free',
        description: 'Basic features for getting started',
        monthlyPrice: 0,
        yearlyPrice: 0,
        features: [
          PlanFeature(
            title: 'Up to 3 highlights/month',
            description: 'Create basic highlights',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Basic editing tools',
            description: 'Simple trim and cut features',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Export in 720p',
            description: 'Standard definition exports',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Advanced AI features',
            description: 'AI-powered highlight detection',
            isIncluded: false,
          ),
          PlanFeature(
            title: 'Priority processing',
            description: 'Faster video processing',
            isIncluded: false,
          ),
          PlanFeature(
            title: 'Cloud storage',
            description: '10GB cloud backup',
            isIncluded: false,
          ),
        ],
      ),
      const SubscriptionPlanInfo(
        plan: SubscriptionPlan.pro,
        name: 'Pro',
        description: 'Perfect for content creators',
        monthlyPrice: 9.99,
        yearlyPrice: 99.99,
        isPopular: true,
        features: [
          PlanFeature(
            title: 'Unlimited highlights',
            description: 'No monthly limits',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Advanced editing tools',
            description: 'Professional editing features',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Export up to 4K',
            description: 'Ultra high definition exports',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Advanced AI features',
            description: 'AI-powered highlight detection',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Priority processing',
            description: 'Faster video processing',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Cloud storage',
            description: '100GB cloud backup',
            isIncluded: true,
          ),
        ],
      ),
      const SubscriptionPlanInfo(
        plan: SubscriptionPlan.premium,
        name: 'Premium',
        description: 'For professional teams',
        monthlyPrice: 19.99,
        yearlyPrice: 199.99,
        features: [
          PlanFeature(
            title: 'Everything in Pro',
            description: 'All Pro features included',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Team collaboration',
            description: 'Share projects with team',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Custom branding',
            description: 'Add your logo and branding',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'API access',
            description: 'Integrate with your tools',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Premium support',
            description: '24/7 priority support',
            isIncluded: true,
          ),
          PlanFeature(
            title: 'Unlimited cloud storage',
            description: 'No storage limits',
            isIncluded: true,
          ),
        ],
      ),
    ];

    emit(state.copyWith(
      availablePlans: mockPlans,
      subscriptionEndDate: DateTime.now().add(const Duration(days: 23)),
      isLoading: false,
    ));
  }

  void selectBillingCycle(BillingCycle cycle) {
    emit(state.copyWith(selectedBillingCycle: cycle));
  }

  void selectPlan(SubscriptionPlan plan) {
    emit(state.copyWith(selectedPlan: plan));
  }

  Future<bool> subscribeToPlan() async {
    emit(state.copyWith(isProcessingPayment: true));

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 3));

      // In real app, call payment API
      // final result = await accountService.subscribeToPlan(
      //   plan: state.selectedPlan,
      //   billingCycle: state.selectedBillingCycle,
      // );

      emit(state.copyWith(
        currentPlan: state.selectedPlan,
        currentBillingCycle: state.selectedBillingCycle,
        subscriptionEndDate: _calculateEndDate(),
        isSubscriptionActive: true,
        autoRenew: true,
        isProcessingPayment: false,
      ));

      return true;
    } catch (e) {
      emit(state.copyWith(isProcessingPayment: false));
      return false;
    }
  }

  Future<bool> cancelSubscription() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // In real app, call cancellation API
      // await accountService.cancelSubscription();

      emit(state.copyWith(
        autoRenew: false,
        isLoading: false,
      ));

      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      return false;
    }
  }

  Future<bool> reactivateSubscription() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(
        autoRenew: true,
        isLoading: false,
      ));

      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      return false;
    }
  }

  Future<bool> changePlan(SubscriptionPlan newPlan) async {
    emit(state.copyWith(isProcessingPayment: true));

    try {
      // Simulate plan change
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(
        currentPlan: newPlan,
        subscriptionEndDate: _calculateEndDate(),
        isProcessingPayment: false,
      ));

      return true;
    } catch (e) {
      emit(state.copyWith(isProcessingPayment: false));
      return false;
    }
  }

  Future<void> restorePurchases() async {
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate restore purchases
      await Future.delayed(const Duration(seconds: 2));

      // In real app, restore from platform stores
      // final restored = await accountService.restorePurchases();

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  DateTime _calculateEndDate() {
    final now = DateTime.now();
    switch (state.selectedBillingCycle) {
      case BillingCycle.monthly:
        return now.add(const Duration(days: 30));
      case BillingCycle.yearly:
        return now.add(const Duration(days: 365));
    }
  }

  String formatPrice(double price) {
    if (price == 0) return 'Free';
    return '\$${price.toStringAsFixed(2)}';
  }

  String formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  bool isPlanUpgrade(SubscriptionPlan targetPlan) {
    final currentIndex = SubscriptionPlan.values.indexOf(state.currentPlan);
    final targetIndex = SubscriptionPlan.values.indexOf(targetPlan);
    return targetIndex > currentIndex;
  }

  bool isPlanDowngrade(SubscriptionPlan targetPlan) {
    final currentIndex = SubscriptionPlan.values.indexOf(state.currentPlan);
    final targetIndex = SubscriptionPlan.values.indexOf(targetPlan);
    return targetIndex < currentIndex;
  }
}
