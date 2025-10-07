import 'package:flutter_bump_app/data/remote/bid/bid_request.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IBidRepository extends IBaseRepository {
  Future<PlaceBidResponse> placeBid(PlaceBidRequest request);

  Future<PaginatedResponse<BidResponse>> getBids(
      {int page = 1, int limit = 20});

  Future<BidResponse> getBidDetail(String bidId);

  Future<CancelBidResponse> cancelBid(String bidId);

  Future<BidResponse> acceptBid(String bidId);

  Future<BidResponse> rejectBid(String bidId);

  Future<PaginatedResponse<BidResponse>> getMySponsorBids(
      {int page = 1, int limit = 20});

  Future<PaginatedResponse<BidResponse>> getCreatorBids(String creatorId,
      {int page = 1, int limit = 20});

  Future<CreatorBidProfile> getCreatorBidProfile(String creatorId);

  Future<CreatorBidProfile> updateCreatorBidProfile(
      String creatorId, UpdateCreatorProfileRequest request);
}
