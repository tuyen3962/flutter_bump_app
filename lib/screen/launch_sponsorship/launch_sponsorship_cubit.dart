import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';

import 'launch_sponsorship_state.dart';

class LaunchSponsorshipCubit extends BaseCubit<LaunchSponsorshipState> {
  late final AccountService accountService = locator.get();

  LaunchSponsorshipCubit()
      : super(const LaunchSponsorshipState(
          availableRequirements: [
            {'id': 'r1', 'label': 'Brand mention in first 5s'},
            {'id': 'r2', 'label': 'Hashtag #SPONSOR.FUN visible'},
            {'id': 'r3', 'label': 'Product shot minimum 3s'},
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

  void toggleRequirement(String reqId) {
    final newRequirements = List<String>.from(state.selectedRequirements);
    if (newRequirements.contains(reqId)) {
      newRequirements.remove(reqId);
    } else {
      newRequirements.add(reqId);
    }
    emit(state.copyWith(selectedRequirements: newRequirements));
  }
}
