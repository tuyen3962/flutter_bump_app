import 'package:json_annotation/json_annotation.dart';
import '../base_response.dart';

part 'highlight_response.g.dart';

@JsonSerializable()
class Highlight {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String userId;
  final String title;
  final String? description;
  final String videoUrl;
  final String? thumbnailUrl;
  final double duration;
  final List<String>? tags;
  final bool isPublic;
  final int viewCount;
  final int likeCount;

  Highlight({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userId,
    required this.title,
    this.description,
    required this.videoUrl,
    this.thumbnailUrl,
    required this.duration,
    this.tags,
    this.isPublic = false,
    this.viewCount = 0,
    this.likeCount = 0,
  });

  factory Highlight.fromJson(Map<String, dynamic> json) =>
      _$HighlightFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightToJson(this);
}

@JsonSerializable()
class ListHighlightsResponse {
  final List<Highlight> data;
  @JsonKey(name: 'paginate')
  final PaginationMeta pagination;

  ListHighlightsResponse({
    required this.data,
    required this.pagination,
  });

  factory ListHighlightsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListHighlightsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListHighlightsResponseToJson(this);
}

@JsonSerializable()
class HighlightAnalytics {
  final String highlightId;
  final int totalViews;
  final int uniqueViews;
  final double averageWatchTime;
  final Map<String, int> viewsByCountry;
  final Map<String, int> viewsByDevice;
  final List<Map<String, dynamic>> dailyViews;

  HighlightAnalytics({
    required this.highlightId,
    required this.totalViews,
    required this.uniqueViews,
    required this.averageWatchTime,
    required this.viewsByCountry,
    required this.viewsByDevice,
    required this.dailyViews,
  });

  factory HighlightAnalytics.fromJson(Map<String, dynamic> json) =>
      _$HighlightAnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightAnalyticsToJson(this);
}
