import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_bump_app/data/remote/response/highlights/highlight_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';

part 'highlight_api.g.dart';

@RestApi()
abstract class HighlightApi {
  factory HighlightApi(Dio dio, {String? baseUrl}) = _HighlightApi;

  @GET('/api/highlights')
  Future<ListHighlightsResponse> getHighlights(
      @Queries() Map<String, dynamic> queries);

  @POST('/api/highlights')
  Future<BaseResponse<Highlight>> createHighlight(
      @Body() Map<String, dynamic> request);

  @GET('/api/highlights/{id}')
  Future<BaseResponse<Highlight>> getHighlight(@Path('id') String id);

  @PUT('/api/highlights/{id}')
  Future<BaseResponse<Highlight>> updateHighlight(
    @Path('id') String id,
    @Body() Map<String, dynamic> request,
  );

  @DELETE('/api/highlights/{id}')
  Future<BaseResponse<dynamic>> deleteHighlight(@Path('id') String id);

  @GET('/api/highlights/{id}/analytics')
  Future<BaseResponse<HighlightAnalytics>> getHighlightAnalytics(
      @Path('id') String id);

  // @GET('/api/highlights/analytics/overview')
  // Future<Map<String, dynamic>> getAnalyticsOverview();

  // @GET('/api/highlights/analytics/sync-status')
  // Future<Map<String, dynamic>> getAnalyticsSyncStatus();

  // @GET('/api/highlights/analytics/sync-info')
  // Future<Map<String, dynamic>> getAnalyticsSyncInfo();

  // @POST('/api/highlights/analytics/trigger-sync')
  // Future<Map<String, dynamic>> triggerAnalyticsSync();
}
