import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_request.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'bid_api.g.dart';

@RestApi()
abstract class BidApi {
  factory BidApi(Dio dio, {String? baseUrl}) = _BidApi;

  @POST('/api/bids')
  Future<BaseResponse<PlaceBidResponse>> placeBid(
      @Body() PlaceBidRequest request);

  @GET('/api/bids')
  Future<PaginatedResponse<BidResponse>> getBids();

  @GET('/api/bids/{bidId}')
  Future<BaseResponse<BidResponse>> getBidDetail(@Path('bidId') String bidId);

  @POST('/api/bids/{bidId}/cancel')
  Future<BaseResponse<CancelBidResponse>> cancelBid(
      @Path('bidId') String bidId);

  // Accept a bid (creator action)
  @POST('/api/bids/{bidId}/accept')
  Future<BaseResponse<BidResponse>> acceptBid(@Path('bidId') String bidId);

  // Reject a bid (creator action)
  @POST('/api/bids/{bidId}/reject')
  Future<BaseResponse<BidResponse>> rejectBid(@Path('bidId') String bidId);

  // List my bids as sponsor
  @GET('/api/sponsors/me/bids')
  Future<PaginatedResponse<BidResponse>> getMySponsorBids(
      @Queries() Map<String, dynamic>? queries);

  // List bids received by a creator
  @GET('/api/creators/{creatorId}/bids')
  Future<PaginatedResponse<BidResponse>> getCreatorBids(
    @Path('creatorId') String creatorId,
    @Queries() Map<String, dynamic>? queries,
  );

  @GET('/api/creators/{creatorId}/bid-profile')
  Future<BaseResponse<CreatorBidProfile>> getCreatorBidProfile(
      @Path('creatorId') String creatorId);

  @PATCH('/api/creators/{creatorId}/bid-profile')
  Future<BaseResponse<CreatorBidProfile>> updateCreatorBidProfile(
    @Path('creatorId') String creatorId,
    @Body() UpdateCreatorProfileRequest request,
  );
}
