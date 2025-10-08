import 'package:flutter_bump_app/data/model/bid_model.dart';
import 'package:flutter_bump_app/data/model/creator_model.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_api.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_request.dart';
import 'package:flutter_bump_app/data/remote/bid/bid_response.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:flutter_bump_app/data/repository/bid/ibid_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IBidRepository)
class BidRepository extends IBidRepository {
  final BidApi bidApi;

  BidRepository(this.bidApi);

  @override
  Future<PlaceBidResponse> placeBid(PlaceBidRequest request) async {
    final response = await bidApi.placeBid(request);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<PaginatedResponse<BidModel>> getBids(
      {int page = 1, int limit = 20}) async {
    return await bidApi.getBids();
  }

  @override
  Future<PaginatedResponse<CreatorModel>> getAllCreatorBids(
      {int page = 1, int limit = 20}) async {
    try {
      final result =
          await bidApi.getAllBids(GetAllBidsRequest(page: page, limit: limit));
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<BidModel> getBidDetail(String bidId) async {
    final response = await bidApi.getBidDetail(bidId);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<CancelBidResponse> cancelBid(String bidId) async {
    final response = await bidApi.cancelBid(bidId);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<BidModel> acceptBid(String bidId) async {
    final response = await bidApi.acceptBid(bidId);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<BidModel> rejectBid(String bidId) async {
    final response = await bidApi.rejectBid(bidId);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<PaginatedResponse<BidModel>> getMySponsorBids(
      {int page = 1, int limit = 20}) async {
    return await bidApi.getMySponsorBids({'page': page, 'limit': limit});
  }

  @override
  Future<PaginatedResponse<BidModel>> getCreatorBids(String creatorId,
      {int page = 1, int limit = 20}) async {
    return await bidApi
        .getCreatorBids(creatorId, {'page': page, 'limit': limit});
  }

  @override
  Future<CreatorBidProfile> getCreatorBidProfile(String creatorId) async {
    final response = await bidApi.getCreatorBidProfile(creatorId);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<CreatorBidProfile> updateCreatorBidProfile(
      String creatorId, UpdateCreatorProfileRequest request) async {
    final response = await bidApi.updateCreatorBidProfile(creatorId, request);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }
}
