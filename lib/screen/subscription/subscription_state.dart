import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';

enum SubscriptionPlan { free, pro, premium }

enum BillingCycle { monthly, yearly }

class PlanFeature {
  final String title;
  final String description;
  final bool isIncluded;

  const PlanFeature({
    required this.title,
    required this.description,
    required this.isIncluded,
  });
}

class SubscriptionPlanInfo {
  final SubscriptionPlan plan;
  final String name;
  final String description;
  final double monthlyPrice;
  final double yearlyPrice;
  final List<PlanFeature> features;
  final bool isPopular;

  const SubscriptionPlanInfo({
    required this.plan,
    required this.name,
    required this.description,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.features,
    this.isPopular = false,
  });

  double getPrice(BillingCycle cycle) {
    return cycle == BillingCycle.monthly ? monthlyPrice : yearlyPrice;
  }

  String getPriceText(BillingCycle cycle) {
    final price = getPrice(cycle);
    return cycle == BillingCycle.monthly 
        ? '\$${price.toStringAsFixed(2)}/month'
        : '\$${price.toStringAsFixed(2)}/year';
  }
}

class SubscriptionState extends BaseState {
  final SubscriptionPlan currentPlan;
  final BillingCycle currentBillingCycle;
  final DateTime? subscriptionEndDate;
  final bool isSubscriptionActive;
  final bool autoRenew;
  final BillingCycle selectedBillingCycle;
  final SubscriptionPlan selectedPlan;
  final bool isLoading;
  final bool isProcessingPayment;
  final List<SubscriptionPlanInfo> availablePlans;

  const SubscriptionState({
    this.currentPlan = SubscriptionPlan.pro,
    this.currentBillingCycle = BillingCycle.monthly,
    this.subscriptionEndDate,
    this.isSubscriptionActive = true,
    this.autoRenew = true,
    this.selectedBillingCycle = BillingCycle.monthly,
    this.selectedPlan = SubscriptionPlan.pro,
    this.isLoading = false,
    this.isProcessingPayment = false,
    this.availablePlans = const [],
  });

  SubscriptionState copyWith({
    SubscriptionPlan? currentPlan,
    BillingCycle? currentBillingCycle,
    DateTime? subscriptionEndDate,
    bool? isSubscriptionActive,
    bool? autoRenew,
    BillingCycle? selectedBillingCycle,
    SubscriptionPlan? selectedPlan,
    bool? isLoading,
    bool? isProcessingPayment,
    List<SubscriptionPlanInfo>? availablePlans,
  }) {
    return SubscriptionState(
      currentPlan: currentPlan ?? this.currentPlan,
      currentBillingCycle: currentBillingCycle ?? this.currentBillingCycle,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      isSubscriptionActive: isSubscriptionActive ?? this.isSubscriptionActive,
      autoRenew: autoRenew ?? this.autoRenew,
      selectedBillingCycle: selectedBillingCycle ?? this.selectedBillingCycle,
      selectedPlan: selectedPlan ?? this.selectedPlan,
      isLoading: isLoading ?? this.isLoading,
      isProcessingPayment: isProcessingPayment ?? this.isProcessingPayment,
      availablePlans: availablePlans ?? this.availablePlans,
    );
  }

  String get currentPlanName {
    switch (currentPlan) {
      case SubscriptionPlan.free:
        return 'Free';
      case SubscriptionPlan.pro:
        return 'Pro';
      case SubscriptionPlan.premium:
        return 'Premium';
    }
  }

  String get statusText {
    if (!isSubscriptionActive) return 'Inactive';
    if (subscriptionEndDate == null) return 'Active';
    
    final daysLeft = subscriptionEndDate!.difference(DateTime.now()).inDays;
    if (daysLeft <= 0) return 'Expired';
    if (daysLeft <= 7) return 'Expires in $daysLeft days';
    return 'Active';
  }

  bool get canUpgrade => currentPlan != SubscriptionPlan.premium;
  bool get canDowngrade => currentPlan != SubscriptionPlan.free;

  SubscriptionPlanInfo? getCurrentPlanInfo() {
    return availablePlans.where((plan) => plan.plan == currentPlan).firstOrNull;
  }

  SubscriptionPlanInfo? getSelectedPlanInfo() {
    return availablePlans.where((plan) => plan.plan == selectedPlan).firstOrNull;
  }

  double get yearlySavingsPercentage {
    final selectedPlanInfo = getSelectedPlanInfo();
    if (selectedPlanInfo == null) return 0;
    
    final monthlyTotal = selectedPlanInfo.monthlyPrice * 12;
    final yearlyPrice = selectedPlanInfo.yearlyPrice;
    return ((monthlyTotal - yearlyPrice) / monthlyTotal) * 100;
  }

  @override
  List<Object?> get props => [
        currentPlan,
        currentBillingCycle,
        subscriptionEndDate,
        isSubscriptionActive,
        autoRenew,
        selectedBillingCycle,
        selectedPlan,
        isLoading,
        isProcessingPayment,
        availablePlans,
      ];
}