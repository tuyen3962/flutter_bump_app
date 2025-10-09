import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:flutter_bump_app/data/remote/campaign/campaign_request.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class ICampaignRepository extends IBaseRepository {
  Future<PaginatedResponse<CampaignModel>> getSetupCampaigns({
    int page = 1,
    int limit = 10,
    String? query,
    CampaignStatus? status,
  });
  Future<PaginatedResponse<CampaignModel>> getMyCampaigns(
      {int page = 1, int limit = 10, String? query, CampaignStatus? status});

  Future<CampaignModel> getCampaignById(String id);

  Future<CampaignModel> updateCampaign(
      String id, UpdateCampaignRequest request);
}
