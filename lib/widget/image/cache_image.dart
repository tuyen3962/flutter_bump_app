import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/widget/default_image.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    this.imageUrl = '',
    super.key,
    this.size,
    this.height,
    this.width,
    this.boxFit,
    this.defaultImage,
  });

  final String imageUrl;
  final double? size;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Widget? defaultImage;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty || imageUrl == "https://image.com") {
      return _defaultImage;
    }
    return CachedNetworkImage(
        imageUrl: imageUrl,
        width: (width ?? size)?.w,
        height: (height ?? size)?.w,
        fit: boxFit ?? BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        // progressIndicatorBuilder: (context, value, progress) =>
        //     const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => url.isEmpty
            ? _defaultImage
            : Image.network(url,
                width: (width ?? size)?.w,
                height: (height ?? size)?.w,
                fit: boxFit ?? BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _defaultImage));
  }

  Widget get _defaultImage =>
      defaultImage ??
      DefaultImage(
        fit: boxFit,
        size: size?.w,
        width: (width ?? size)?.w,
        height: (height ?? size)?.w,
      );
}
