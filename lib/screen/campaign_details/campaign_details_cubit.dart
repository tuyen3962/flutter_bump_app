import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/service/account_service.dart';
import 'package:flutter_bump_app/config/service/app_service.dart';
import 'package:flutter_bump_app/data/repository/campaign/icampaign_repository.dart';
import 'package:flutter_bump_app/screen/campaign_details/campaign_details_parameter.dart';
import 'package:flutter_bump_app/utils/loading.dart';

import 'campaign_details_state.dart';

class CampaignDetailsCubit extends BaseCubit<CampaignDetailsState> {
  late final AccountService accountService = locator.get();
  final ICampaignRepository campaignRepository;

  final CampaignDetailsParameter parameter;

  CampaignDetailsCubit({
    required this.parameter,
    required this.campaignRepository,
  }) : super(CampaignDetailsState());

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  Future<void> onRefresh() async {
    showLoading();
    try {
      final campaign =
          await campaignRepository.getCampaignById(parameter.campaign.id ?? '');
      emit(state.copyWith(campaign: campaign));
    } catch (e) {
      emit(state.copyWith(notFound: true));
    }
    dismissLoading();
  }
}
