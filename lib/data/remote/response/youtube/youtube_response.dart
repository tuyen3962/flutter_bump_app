import 'package:json_annotation/json_annotation.dart';

part 'youtube_response.g.dart';

@JsonSerializable()
class YouTubeLinkResponse {
  final bool success;
  final String authUrl;
  final String state;
  final String message;

  YouTubeLinkResponse({
    required this.success,
    required this.authUrl,
    required this.state,
    required this.message,
  });

  factory YouTubeLinkResponse.fromJson(Map<String, dynamic> json) =>
      _$YouTubeLinkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeLinkResponseToJson(this);
}

@JsonSerializable()
class YouTubeChannelInfo {
  final String id;
  final String title;
  final String? description;
  final String? thumbnailUrl;
  final int? subscriberCount;
  final int? videoCount;
  final int? viewCount;

  YouTubeChannelInfo({
    required this.id,
    required this.title,
    this.description,
    this.thumbnailUrl,
    this.subscriberCount,
    this.videoCount,
    this.viewCount,
  });

  factory YouTubeChannelInfo.fromJson(Map<String, dynamic> json) =>
      _$YouTubeChannelInfoFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeChannelInfoToJson(this);
}

@JsonSerializable()
class YouTubeStatusResponse {
  final bool isLinked;
  final YouTubeChannelInfo? channelInfo;
  final List<String>? scopes;
  final DateTime? tokenExpiry;
  final DateTime? linkedAt;

  YouTubeStatusResponse({
    required this.isLinked,
    this.channelInfo,
    this.scopes,
    this.tokenExpiry,
    this.linkedAt,
  });

  factory YouTubeStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$YouTubeStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeStatusResponseToJson(this);
}

enum YouTubeUploadStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('uploading')
  uploading,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}

@JsonSerializable()
class YouTubeUploadJob {
  final String id;
  final YouTubeUploadStatus status;
  final String? youtubeVideoId;
  final double progress;
  final int? estimatedTimeRemaining;

  YouTubeUploadJob({
    required this.id,
    required this.status,
    this.youtubeVideoId,
    required this.progress,
    this.estimatedTimeRemaining,
  });

  factory YouTubeUploadJob.fromJson(Map<String, dynamic> json) =>
      _$YouTubeUploadJobFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeUploadJobToJson(this);
}

@JsonSerializable()
class YouTubeUploadResponse {
  final bool success;
  final String message;
  final YouTubeUploadJob uploadJob;

  YouTubeUploadResponse({
    required this.success,
    required this.message,
    required this.uploadJob,
  });

  factory YouTubeUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$YouTubeUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeUploadResponseToJson(this);
}
