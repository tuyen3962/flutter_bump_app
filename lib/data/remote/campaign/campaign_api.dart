import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/model/campagin.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'campaign_request.dart';

part 'campaign_api.g.dart';

@RestApi()
abstract class CampaignApi {
  factory CampaignApi(Dio dio, {String? baseUrl}) = _CampaignApi;

  @GET('/api/campaign/setup')
  Future<BaseResponse<PaginatedResponse<CampaignModel>>> getSetupCampaigns(
      @Queries() FilterCampaignRequest request);

  @GET('/api/campaign/{id}')
  Future<BaseResponse<CampaignModel>> getCampaignById(@Path('id') String id);

  @PUT('/api/campaign/{id}')
  Future<BaseResponse<CampaignModel>> updateCampaign(
      @Path('id') String id, @Body() UpdateCampaignRequest request);

  @GET('/api/campaign/my-campaigns')
  Future<BaseResponse<PaginatedResponse<CampaignModel>>> getMyCampaigns(
      @Queries() FilterCampaignRequest request);
}
