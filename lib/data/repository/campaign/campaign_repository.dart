import 'package:flutter_bump_app/data/enum/app_enum.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:flutter_bump_app/data/remote/campaign/campaign_api.dart';
import 'package:flutter_bump_app/data/remote/campaign/campaign_request.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/campaign/icampaign_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ICampaignRepository)
class CampaignRepository extends ICampaignRepository {
  final CampaignApi campaignApi;

  CampaignRepository(this.campaignApi);

  @override
  Future<CampaignModel> getCampaignById(String id) async {
    try {
      final response = await campaignApi.getCampaignById(id);
      if (response.isSuccess) {
        return response.data!;
      }
      throw Exception(response.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PaginatedResponse<CampaignModel>> getMyCampaigns(
      {int page = 1,
      int limit = 10,
      String? query,
      CampaignStatus? status}) async {
    try {
      final response = await campaignApi.getMyCampaigns(FilterCampaignRequest(
          page: page, limit: limit, query: query, status: status));

      return response.data!;
    } catch (e) {
      // throw Exception(e);
      return PaginatedResponse(
          data: [],
          pagination: PaginationMeta(
              totalPages: 0,
              totalItems: 0,
              canNext: false,
              canPrev: false,
              currentPage: 0,
              limit: 0));
    }
  }

  @override
  Future<PaginatedResponse<CampaignModel>> getSetupCampaigns(
      {int page = 1,
      int limit = 10,
      String? query,
      CampaignStatus? status}) async {
    try {
      final response = await campaignApi.getSetupCampaigns(
          FilterCampaignRequest(
              page: page,
              limit: limit,
              query: query,
              status: status ?? CampaignStatus.PENDING));
      return response.data!;
    } catch (e) {
      return PaginatedResponse(
          data: [],
          pagination: PaginationMeta(
              totalPages: 0,
              totalItems: 0,
              canNext: false,
              canPrev: false,
              currentPage: 0,
              limit: 0));
    }
  }

  @override
  Future<CampaignModel> updateCampaign(
      String id, UpdateCampaignRequest request) async {
    try {
      final response = await campaignApi.updateCampaign(id, request);
      if (response.isSuccess) {
        return response.data!;
      }
      throw Exception(response.message);
    } catch (e) {
      throw Exception(e);
    }
  }
}
