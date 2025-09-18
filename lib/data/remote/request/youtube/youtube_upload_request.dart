import 'package:json_annotation/json_annotation.dart';

part 'youtube_upload_request.g.dart';

enum YouTubePrivacySetting {
  @JsonValue('public')
  public,
  @JsonValue('private')
  private,
  @JsonValue('unlisted')
  unlisted,
}

@JsonSerializable()
class YouTubeUploadRequest {
  final String videoId;
  final String? title;
  final String? description;
  final List<String>? tags;
  final String categoryId;
  final YouTubePrivacySetting privacy;
  final double? thumbnailTime;

  YouTubeUploadRequest({
    required this.videoId,
    this.title,
    this.description,
    this.tags,
    this.categoryId = '20',
    this.privacy = YouTubePrivacySetting.private,
    this.thumbnailTime,
  });

  factory YouTubeUploadRequest.fromJson(Map<String, dynamic> json) =>
      _$YouTubeUploadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeUploadRequestToJson(this);
}

@JsonSerializable()
class YouTubeLinkInitiateRequest {
  final List<String> scopes;
  final String? state;

  YouTubeLinkInitiateRequest({
    this.scopes = const [
      'https://www.googleapis.com/auth/youtube.upload',
      'https://www.googleapis.com/auth/youtube.readonly',
      'https://www.googleapis.com/auth/userinfo.profile'
    ],
    this.state,
  });

  factory YouTubeLinkInitiateRequest.fromJson(Map<String, dynamic> json) =>
      _$YouTubeLinkInitiateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$YouTubeLinkInitiateRequestToJson(this);
}
