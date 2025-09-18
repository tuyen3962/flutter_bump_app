import 'package:json_annotation/json_annotation.dart';
import '../../response/video/video_response.dart';

part 'update_video_status_request.g.dart';

@JsonSerializable()
class UpdateVideoStatusRequest {
  final String videoId;
  final UploadStatus uploadStatus;
  final String? fileUrl;
  final String? thumbnail;
  final double? duration;
  final int? size;
  final String? name;

  UpdateVideoStatusRequest({
    required this.videoId,
    required this.uploadStatus,
    this.fileUrl,
    this.thumbnail,
    this.duration,
    this.size,
    this.name,
  });

  factory UpdateVideoStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVideoStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateVideoStatusRequestToJson(this);
}
