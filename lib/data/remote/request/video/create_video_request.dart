import 'package:json_annotation/json_annotation.dart';

part 'create_video_request.g.dart';

@JsonSerializable()
class CreateVideoRequest {
  final String name;
  final String fileUrl;
  final String? batchId;
  final int duration;
  final int size;

  CreateVideoRequest({
    required this.name,
    required this.fileUrl,
    this.batchId,
    this.duration = 0,
    this.size = 0,
  });

  factory CreateVideoRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateVideoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateVideoRequestToJson(this);
}
