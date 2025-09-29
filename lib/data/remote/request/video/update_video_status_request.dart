import 'package:json_annotation/json_annotation.dart';

import '../../response/video/video_response.dart';

part 'update_video_status_request.g.dart';

@JsonSerializable()
class UpdateVideoBatchStatusRequest {
  final String batchId;
  final List<UpdateVideoStatusRequest> videos;

  UpdateVideoBatchStatusRequest({
    required this.batchId,
    required this.videos,
  });

  factory UpdateVideoBatchStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVideoBatchStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateVideoBatchStatusRequestToJson(this);
}

@JsonSerializable()
class UpdateVideoStatusRequest {
  final String videoId;
  final UploadStatus? uploadStatus;
  final int? progress;

  UpdateVideoStatusRequest({
    required this.videoId,
    this.uploadStatus,
    this.progress,
  });

  factory UpdateVideoStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVideoStatusRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final json = _$UpdateVideoStatusRequestToJson(this);
    json.removeWhere((key, value) => value == null || value == '');
    return json;
  }
}
