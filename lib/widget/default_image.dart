import 'package:flutter/material.dart';
import 'package:flutter_bump_app/widget/image_asset_custom.dart';

class DefaultImage extends StatelessWidget {
  const DefaultImage({
    super.key,
    this.fit,
    this.size,
    this.height,
    this.width,
    this.imagePath,
  });

  final double? size;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ImageAssetCustom(
      imagePath: imagePath ?? '',
      size: size,
      boxFit: fit,
      width: width,
      height: height,
    );
  }
}
