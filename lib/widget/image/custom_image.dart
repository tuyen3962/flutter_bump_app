import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/widget/default_image.dart';
import 'package:flutter_bump_app/widget/image/cache_image.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {super.key,
      this.imageUrl = '',
      this.imageFile,
      this.height,
      this.width,
      this.size,
      this.boxFit,
      this.radius = 0});

  final String imageUrl;
  final File? imageFile;
  final double? size;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: imageFile != null
          ? Image.file(imageFile!,
              width: (width ?? size)?.w,
              height: (height ?? size)?.w,
              fit: boxFit ?? BoxFit.cover,
              errorBuilder: (context, url, error) => defaultImage)
          : CacheImage(
              imageUrl: imageUrl,
              width: (width ?? size)?.w,
              height: (height ?? size)?.w,
              boxFit: boxFit ?? BoxFit.cover,
              defaultImage: defaultImage),
    );
  }

  Widget get defaultImage => DefaultImage(
        width: (width ?? size)?.w,
        height: (height ?? size)?.w,
        fit: boxFit ?? BoxFit.cover,
      );
}
