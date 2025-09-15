// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'sticker.g.dart';

@JsonSerializable()
class Sticker {
  String? id;
  @JsonKey(name: 'bucket_id')
  String? bucketId;
  @JsonKey(name: 'sticker_images')
  List<String>? stikcerImageIds;
  String? name;

  Sticker({
    this.id,
    this.bucketId,
    this.stikcerImageIds,
    this.name,
  });

  Sticker copyWith({
    String? id,
    String? bucketId,
    List<String>? stikcerImageIds,
    String? name,
  }) {
    return Sticker(
      id: id ?? this.id,
      bucketId: bucketId ?? this.bucketId,
      stikcerImageIds: stikcerImageIds ?? this.stikcerImageIds,
      name: name ?? this.name,
    );
  }

  factory Sticker.fromJson(Map<String, dynamic> json) =>
      _$StickerFromJson(json);

  Map<String, dynamic> toJson() => _$StickerToJson(this);
}
