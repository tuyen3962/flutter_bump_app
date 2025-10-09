// import 'package:flutter_bump_app/data/enum/app_enum.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'campaign_response.g.dart';

// @JsonSerializable()
// class CampaignResponse {
//   final String? id;
//   final String? title;
//   final String? description;
//   final String? category;
//   final double? budget;
//   final double? maxBidAmount;
//   final double? currentBidAmount;
//   final int? duration;
//   final String? targetAudience;
//   final List<String>? tags;
//   final Map<String, dynamic>? metadata;
//   @JsonKey(unknownEnumValue: CampaignStatus.NONE)
//   final CampaignStatus? status;
//   final String? createdBy;
//   final String? createdAt;
//   final String? updatedAt;
//   final String? launchedAt;
//   final String? endedAt;
//   final CampaignAnalyticsResponse? analytics;
//   final List<CampaignBidResponse>? bids;

//   CampaignResponse({
//     this.id,
//     this.title,
//     this.description,
//     this.category,
//     this.budget,
//     this.maxBidAmount,
//     this.currentBidAmount,
//     this.duration,
//     this.targetAudience,
//     this.tags,
//     this.metadata,
//     this.status,
//     this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//     this.launchedAt,
//     this.endedAt,
//     this.analytics,
//     this.bids,
//   });

//   factory CampaignResponse.fromJson(Map<String, dynamic> json) =>
//       _$CampaignResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$CampaignResponseToJson(this);
// }

// @JsonSerializable()
// class CampaignAnalyticsResponse {
//   final int? totalViews;
//   final int? totalClicks;
//   final int? totalBids;
//   final double? totalSpent;
//   final double? averageBidAmount;
//   final double? highestBidAmount;
//   final double? conversionRate;
//   final Map<String, dynamic>? demographics;
//   final List<CampaignPerformanceData>? performanceData;

//   CampaignAnalyticsResponse({
//     this.totalViews,
//     this.totalClicks,
//     this.totalBids,
//     this.totalSpent,
//     this.averageBidAmount,
//     this.highestBidAmount,
//     this.conversionRate,
//     this.demographics,
//     this.performanceData,
//   });

//   factory CampaignAnalyticsResponse.fromJson(Map<String, dynamic> json) =>
//       _$CampaignAnalyticsResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$CampaignAnalyticsResponseToJson(this);
// }

// @JsonSerializable()
// class CampaignPerformanceData {
//   final String? date;
//   final int? views;
//   final int? clicks;
//   final int? bids;
//   final double? spent;

//   CampaignPerformanceData({
//     this.date,
//     this.views,
//     this.clicks,
//     this.bids,
//     this.spent,
//   });

//   factory CampaignPerformanceData.fromJson(Map<String, dynamic> json) =>
//       _$CampaignPerformanceDataFromJson(json);

//   Map<String, dynamic> toJson() => _$CampaignPerformanceDataToJson(this);
// }

// @JsonSerializable()
// class CampaignBidResponse {
//   final String? id;
//   final String? campaignId;
//   final String? bidderId;
//   final String? bidderName;
//   final double? amount;
//   final String? message;
//   final Map<String, dynamic>? metadata;
//   @JsonKey(unknownEnumValue: BidStatus.NO_BID)
//   final BidStatus? status;
//   final String? createdAt;
//   final String? updatedAt;
//   final String? wonAt;

//   CampaignBidResponse({
//     this.id,
//     this.campaignId,
//     this.bidderId,
//     this.bidderName,
//     this.amount,
//     this.message,
//     this.metadata,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.wonAt,
//   });

//   factory CampaignBidResponse.fromJson(Map<String, dynamic> json) =>
//       _$CampaignBidResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$CampaignBidResponseToJson(this);
// }

// enum CampaignStatus { DRAFT, ACTIVE, PAUSED, ENDED, CANCELLED, NONE }
