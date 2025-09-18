import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  String? id;
  String? name;
  String? description;
  String? status;

  VideoModel({this.id, this.name, this.description, this.status});

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
