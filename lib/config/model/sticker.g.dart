// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sticker _$StickerFromJson(Map<String, dynamic> json) => Sticker(
      id: json['id'] as String?,
      bucketId: json['bucket_id'] as String?,
      stikcerImageIds: (json['sticker_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StickerToJson(Sticker instance) => <String, dynamic>{
      'id': instance.id,
      'bucket_id': instance.bucketId,
      'sticker_images': instance.stikcerImageIds,
      'name': instance.name,
    };
