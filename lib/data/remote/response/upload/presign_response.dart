import 'package:json_annotation/json_annotation.dart';

part 'presign_response.g.dart';

@JsonSerializable()
class PreSignResponse {
  final String uploadUrl;
  final String key;
  final String originURL;
  final String bucket;
  final String expiresAt;
  final String contentType;
  final UploadInstructions? uploadInstructions;
  final int maxFileSize;

  PreSignResponse({
    required this.uploadUrl,
    required this.key,
    required this.originURL,
    required this.bucket,
    required this.expiresAt,
    required this.contentType,
    required this.uploadInstructions,
    required this.maxFileSize,
  });

  factory PreSignResponse.fromJson(Map<String, dynamic> json) =>
      _$PreSignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PreSignResponseToJson(this);
}

@JsonSerializable()
class UploadInstructions {
  final String method;
  final Map<String, String> headers;

  UploadInstructions({
    required this.method,
    required this.headers,
  });

  factory UploadInstructions.fromJson(Map<String, dynamic> json) =>
      _$UploadInstructionsFromJson(json);

  Map<String, dynamic> toJson() => _$UploadInstructionsToJson(this);
}
