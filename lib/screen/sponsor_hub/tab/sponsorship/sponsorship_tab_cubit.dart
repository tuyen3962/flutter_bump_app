import 'package:flutter_bump_app/base/widget/cubit/base_cubit.dart';
import 'package:flutter_bump_app/config/constant/app_constant.dart';
import 'package:flutter_bump_app/config/service/campaign_listener.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:flutter_bump_app/data/repository/campaign/icampaign_repository.dart';
import 'package:flutter_bump_app/utils/lazy_list/lazy_list_controller.dart';

import 'sponsorship_tab_state.dart';

class SponsorshipTabCubit extends BaseCubit<SponsorshipTabState> {
  final ICampaignRepository campaignRepository;
  final CampaignListener campaignListener;

  SponsorshipTabCubit({
    required this.campaignRepository,
    required this.campaignListener,
  }) : super(const SponsorshipTabState());

  late final LazyListController<CampaignModel> setupCampaignsListCtrl;
  late final LazyListController<CampaignModel> myCampaignsListCtrl;

  @override
  void onInit() {
    super.onInit();
    campaignListener.listen(_listenEvents);
    setupCampaignsListCtrl = LazyListController(
      limit: LIMIT,
      onLoad: (page) async {
        return campaignRepository.getSetupCampaigns(limit: LIMIT, page: page);
      },
    );
    myCampaignsListCtrl = LazyListController(
      limit: LIMIT,
      onLoad: (page) async {
        final response = await campaignRepository.getMyCampaigns(
            limit: LIMIT, page: page, status: state.filter.campaignStatus);
        return response;
      },
    );

    onRefresh();
  }

  void _listenEvents(BaseCampaignListenerEvent event) {
    if (event is CampaignUpdatedEvent) {
      setupCampaignsListCtrl.removeWhere((e) => e.id == event.campaignId);
      myCampaignsListCtrl.add(event.campaign);
    }
  }

  @override
  Future<void> close() {
    campaignListener.remove(_listenEvents);
    setupCampaignsListCtrl.dispose();
    myCampaignsListCtrl.dispose();
    return super.close();
  }

  Future<void> onRefresh() async {
    await Future.wait([
      setupCampaignsListCtrl.onRefresh(),
      myCampaignsListCtrl.onRefresh(),
    ]);
  }

  void selectSponsorshipFilter(SponsorshipTabFilter filter) {
    emit(state.copyWith(filter: filter));
    myCampaignsListCtrl.onRefresh();
  }
}
