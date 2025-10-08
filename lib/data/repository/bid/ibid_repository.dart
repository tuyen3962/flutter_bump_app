import 'package:flutter_bump_app/data/model/bid_model.dart';
import 'package:flutter_bump_app/data/model/creator_model.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_request.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IBidRepository extends IBaseRepository {
  Future<PlaceBidResponse> placeBid(PlaceBidRequest request);

  Future<PaginatedResponse<BidModel>> getBids({int page = 1, int limit = 20});
  Future<PaginatedResponse<CreatorModel>> getAllCreatorBids(
      {int page = 1, int limit = 20});

  Future<BidModel> getBidDetail(String bidId);

  Future<CancelBidResponse> cancelBid(String bidId);

  Future<BidModel> acceptBid(String bidId);

  Future<BidModel> rejectBid(String bidId);

  Future<PaginatedResponse<BidModel>> getMySponsorBids(
      {int page = 1, int limit = 20});

  Future<PaginatedResponse<BidModel>> getCreatorBids(String creatorId,
      {int page = 1, int limit = 20});

  Future<CreatorBidProfile> getCreatorBidProfile(String creatorId);

  Future<CreatorBidProfile> updateCreatorBidProfile(
      String creatorId, UpdateCreatorProfileRequest request);
}
