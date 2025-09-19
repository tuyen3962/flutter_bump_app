import 'package:json_annotation/json_annotation.dart';
import '../base_response.dart';

part 'video_response.g.dart';

enum VideoFormat {
  @JsonValue('MP4')
  mp4,
  @JsonValue('AVI')
  avi,
  @JsonValue('MOV')
  mov,
  @JsonValue('MKV')
  mkv,
  @JsonValue('FLV')
  flv,
  @JsonValue('WMV')
  wmv,
  @JsonValue('WEBM')
  webm,
  @JsonValue('MPEG')
  mpeg,
  @JsonValue('OTHER')
  other,
}

enum UploadStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('UPLOADING')
  uploading,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('FAILED')
  failed,
}

@JsonSerializable()
class Video {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String userId;
  final String batchId;
  final int batchOrder;
  final String name;
  final double duration;
  final String fileUrl;
  final String thumbnail;
  final VideoFormat format;
  final UploadStatus uploadStatus;
  final int size;

  Video({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userId,
    required this.batchId,
    this.batchOrder = 1,
    required this.name,
    required this.duration,
    required this.fileUrl,
    required this.thumbnail,
    this.format = VideoFormat.mp4,
    this.uploadStatus = UploadStatus.pending,
    required this.size,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
