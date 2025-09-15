import 'package:flutter/material.dart';
import 'package:flutter_bump_app/widget/image/cache_image.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    this.imageUrl,
    this.boxFit,
    this.height,
    this.width,
    this.size,
    this.radius = 0,
    this.onTap,
    this.defaultImage,
  });

  final String? imageUrl;
  final double? size;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final double radius;
  final VoidCallback? onTap;
  final Widget? defaultImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap?.call();
        } else {
          if (imageUrl?.isNotEmpty ?? false) {
            // context.pushRoute(PreviewImageRoute(
            //     parameter: PreviewImageParameter(imageUrl: imageUrl)));
          }
        }
      },
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CacheImage(
            imageUrl: imageUrl ?? '',
            height: size ?? height,
            width: size ?? width,
            defaultImage: defaultImage,
            boxFit: boxFit),
      ),
    );
  }
}
