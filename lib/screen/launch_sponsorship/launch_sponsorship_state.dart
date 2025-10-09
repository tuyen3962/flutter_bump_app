import 'dart:io';

import 'package:flutter_bump_app/base/widget/cubit/base_state.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';

class LaunchSponsorshipState extends BaseState {
  final int currentStep;
  final String channelName;
  final String channelDesc;
  final String website;
  final String twitter;
  final String telegram;
  final String discord;
  final List<String> selectedRequirements;
  final List<Map<String, dynamic>> availableRequirements;
  final File? logo;
  final File? banner;
  final CampaignModel? campaign;
  final String? logoUrl;
  final String? bannerUrl;

  const LaunchSponsorshipState({
    super.isLoading = false,
    this.currentStep = 1,
    this.channelName = '',
    this.channelDesc = '',
    this.website = '',
    this.twitter = '',
    this.telegram = '',
    this.discord = '',
    this.selectedRequirements = const [],
    this.availableRequirements = const [],
    this.logo,
    this.banner,
    this.campaign,
    this.logoUrl,
    this.bannerUrl,
  });

  bool get canProceed {
    if (currentStep == 1) {
      return channelName.isNotEmpty &&
          channelDesc.isNotEmpty &&
          (logo != null || (logoUrl ?? '').isNotEmpty);
    } else if (currentStep == 2) {
      return selectedRequirements.isNotEmpty;
    }
    return false;
  }

  LaunchSponsorshipState copyWith({
    int? currentStep,
    String? channelName,
    String? channelDesc,
    String? website,
    String? twitter,
    String? telegram,
    String? discord,
    List<String>? selectedRequirements,
    List<Map<String, dynamic>>? availableRequirements,
    File? logo,
    File? banner,
    bool? isLoading,
    CampaignModel? campaign,
    String? logoUrl,
    String? bannerUrl,
  }) {
    return LaunchSponsorshipState(
      currentStep: currentStep ?? this.currentStep,
      channelName: channelName ?? this.channelName,
      channelDesc: channelDesc ?? this.channelDesc,
      website: website ?? this.website,
      twitter: twitter ?? this.twitter,
      telegram: telegram ?? this.telegram,
      discord: discord ?? this.discord,
      selectedRequirements: selectedRequirements ?? this.selectedRequirements,
      availableRequirements:
          availableRequirements ?? this.availableRequirements,
      logo: logo ?? this.logo,
      banner: banner ?? this.banner,
      isLoading: isLoading ?? this.isLoading,
      campaign: campaign ?? this.campaign,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        currentStep,
        channelName,
        channelDesc,
        website,
        twitter,
        telegram,
        discord,
        selectedRequirements,
        availableRequirements,
        logo,
        banner,
        campaign,
        logoUrl,
        bannerUrl,
      ];
}
