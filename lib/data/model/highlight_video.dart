import 'package:json_annotation/json_annotation.dart';

part 'highlight_video.g.dart';

@JsonSerializable()
class HighlightVideo {
  String? id;
  String? videoId;
  String? title;
  String? description;
  String? thumbnailUrl;
  String? highlightVideoUrl;
  int? duration;
  int? viewCount;
  int? likeCount;
  bool? isPosted;
  String? youtubeVideoId;
  String? tiktokVideoId;
  String? createdAt;
  int? processingScore;
  List<String>? tags;

  HighlightVideo(
      {this.id,
      this.videoId,
      this.title,
      this.description,
      this.thumbnailUrl,
      this.highlightVideoUrl,
      this.duration,
      this.viewCount,
      this.likeCount,
      this.isPosted,
      this.youtubeVideoId,
      this.tiktokVideoId,
      this.createdAt,
      this.processingScore,
      this.tags});

  factory HighlightVideo.fromJson(Map<String, dynamic> json) =>
      _$HighlightVideoFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightVideoToJson(this);
}
