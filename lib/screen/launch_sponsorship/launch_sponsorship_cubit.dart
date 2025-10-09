import 'dart:io';

import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:flutter_bump_app/data/remote/campaign/campaign_request.dart';
import 'package:flutter_bump_app/data/repository/campaign/icampaign_repository.dart';
import 'package:flutter_bump_app/data/usecase/update_campaign_usecase.dart';
import 'package:flutter_bump_app/utils/flash/toast.dart';
import 'package:flutter_bump_app/utils/loading.dart';

import 'launch_sponsorship_state.dart';

enum UploadBannerType { logo, banner }

class LaunchSponsorshipCubit extends BaseCubit<LaunchSponsorshipState> {
  late final AccountService accountService = locator.get();
  final ICampaignRepository campaignRepository = locator.get();
  final CampaignModel campaign;
  final UpdateCampaignUsecase updateCampaignUsecase;

  LaunchSponsorshipCubit({
    required this.campaign,
    required this.updateCampaignUsecase,
  }) : super(LaunchSponsorshipState(
          channelName: campaign.channelName ?? '',
          channelDesc: campaign.channelDesc ?? '',
          logoUrl: campaign.logo,
          bannerUrl: campaign.banner,
          availableRequirements: const [
            {'id': 'r1', 'label': 'Brand mention in first 5s'},
            // {'id': 'r2', 'label': 'Hashtag #SPONSOR.FUN visible'},
            // {'id': 'r3', 'label': 'Product shot minimum 3s'},
            {'id': 'r4', 'label': 'Call-to-action included'},
          ],
        ));

  void nextStep() {
    if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void goToStep(int step) {
    emit(state.copyWith(currentStep: step));
  }

  void updateChannelName(String value) {
    emit(state.copyWith(channelName: value));
  }

  void updateChannelDesc(String value) {
    emit(state.copyWith(channelDesc: value));
  }

  void updateWebsite(String value) {
    emit(state.copyWith(website: value));
  }

  void updateTwitter(String value) {
    emit(state.copyWith(twitter: value));
  }

  void updateTelegram(String value) {
    emit(state.copyWith(telegram: value));
  }

  void updateDiscord(String value) {
    emit(state.copyWith(discord: value));
  }

  void updateUploadBanner(File value, UploadBannerType type) {
    if (type == UploadBannerType.logo) {
      emit(state.copyWith(logo: value));
    } else {
      emit(state.copyWith(banner: value));
    }
  }

  void toggleRequirement(String reqId) {
    final newRequirements = List<String>.from(state.selectedRequirements);
    if (newRequirements.contains(reqId)) {
      newRequirements.remove(reqId);
    } else {
      newRequirements.add(reqId);
    }
    emit(state.copyWith(selectedRequirements: newRequirements));
  }

  void launchCampaign() async {
    showLoading();

    try {
      final requirements = <Requirements>[];
      for (final req in state.selectedRequirements) {
        final requirement =
            state.availableRequirements.firstWhere((e) => e['id'] == req);
        requirements
            .add(Requirements(label: requirement['label'], isMandatory: true));
      }
      final param = UpdateCampaignUsecaseParam(
        campaign: campaign,
        logo: state.logo,
        banner: state.banner,
        request: UpdateCampaignRequest(
          name: state.channelName,
          description: state.channelDesc,
          requirements: requirements,
        ),
      );
      final response = await updateCampaignUsecase.call(param);
      showSimpleToast('Campaign launched successfully');
      emit(state.copyWith(campaign: response));
    } catch (e) {
      // emit(state.copyWith(isLoading: false));
      showSimpleToast('Error launching campaign');
    }
    dismissLoading();
  }
}
