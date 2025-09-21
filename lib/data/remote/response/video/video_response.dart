import 'package:json_annotation/json_annotation.dart';

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
  @JsonValue('PROGRESS')
  progress,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('FAILED')
  failed,
}

@JsonSerializable()
class Video {
  String id;

  String? userId;
  String? batchId;
  int? batchOrder;
  String? name;
  double? duration;
  String? fileUrl;
  String? thumbnail;
  VideoFormat? format;
  UploadStatus? uploadStatus;
  int? size;

  Video({
    required this.id,
    this.userId,
    this.batchId,
    this.batchOrder = 1,
    this.name,
    this.duration,
    this.fileUrl,
    this.thumbnail,
    this.format = VideoFormat.mp4,
    this.uploadStatus,
    this.size,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
