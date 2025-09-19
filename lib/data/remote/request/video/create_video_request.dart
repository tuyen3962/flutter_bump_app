import 'package:json_annotation/json_annotation.dart';

part 'create_video_request.g.dart';

@JsonSerializable()
class CreateVideoRequest {
  final String name;
  final String fileUrl;

  CreateVideoRequest({
    required this.name,
    required this.fileUrl,
  });

  factory CreateVideoRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateVideoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateVideoRequestToJson(this);
}
