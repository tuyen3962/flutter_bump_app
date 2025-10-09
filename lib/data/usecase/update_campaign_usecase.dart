import 'dart:io';

import 'package:flutter_bump_app/base/usecase/base_usecase.dart';
import 'package:flutter_bump_app/config/service/campaign_listener.dart';
import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:flutter_bump_app/data/remote/campaign/campaign_request.dart';
import 'package:flutter_bump_app/data/repository/campaign/icampaign_repository.dart';
import 'package:injectable/injectable.dart';

import 'upload_image_usecase.dart';

class UpdateCampaignUsecaseParam {
  final CampaignModel campaign;
  final UpdateCampaignRequest request;
  final File? logo;
  final File? banner;

  UpdateCampaignUsecaseParam(
      {required this.campaign, required this.request, this.logo, this.banner});
}

@lazySingleton
class UpdateCampaignUsecase
    extends BaseUseCase<CampaignModel, UpdateCampaignUsecaseParam> {
  final ICampaignRepository campaignRepository;
  final CampaignListener campaignListener;

  final UploadImageUsecase uploadImageUsecase;

  UpdateCampaignUsecase(
      this.campaignRepository, this.uploadImageUsecase, this.campaignListener);

  @override
  Future<CampaignModel> call(UpdateCampaignUsecaseParam param) async {
    var logoUrl = '';
    var bannerUrl = '';
    if (param.logo != null) {
      logoUrl = await uploadImageUsecase.call(param.logo!);
    }
    if (param.banner != null) {
      bannerUrl = await uploadImageUsecase.call(param.banner!);
    }
    final campaign = await campaignRepository.updateCampaign(
        param.campaign.id ?? '',
        param.request.copyWith(
          logo: logoUrl,
          banner: bannerUrl,
          status: CampaignStatus.IN_PROGRESS,
        ));
    campaignListener.emit(CampaignUpdatedEvent(campaign.id ?? '', campaign));
    return campaign;
  }
}
