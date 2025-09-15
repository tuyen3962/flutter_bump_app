import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';
import 'package:flutter_bump_app/widget/image/cache_image.dart';

class CircleAvatarCustom extends StatelessWidget {
  const CircleAvatarCustom({
    super.key,
    this.imageUrl = '',
    this.size = 24,
    this.imageFile,
    this.borderWidth = 0,
    this.borderColor,
    this.defaultWidget,
  });

  final String imageUrl;
  final double size;
  final File? imageFile;
  final Color? borderColor;
  final double borderWidth;
  final Widget? defaultWidget;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      // padding: padding(all: borderWidth),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: borderWidth > 0
              ? Border.all(
                  color: borderColor ?? appTheme.whiteText, width: borderWidth)
              : null),
      child: Padding(
        padding: padding(all: borderWidth),
        child: ClipOval(
          child: imageFile != null
              ? Image.file(
                  imageFile!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  // errorBuilder: (context, url, error) => ImageAssetCustom(
                  //   imagePath: Assets.images.avatar.path,
                  //   size: size,
                  //   sizeBaseOnWidth: true,
                  //   boxFit: BoxFit.fill,
                  // ),
                )
              : CacheImage(
                  imageUrl: imageUrl,
                  width: size,
                  height: size,
                  boxFit: BoxFit.cover,
                  // defaultImage: defaultWidget ??
                  //     ImageAssetCustom(
                  //       imagePath: Assets.images.avatar.path,
                  //       boxFit: BoxFit.fill,
                  //       sizeBaseOnWidth: true,
                  //       size: size,
                  //     ),
                ),
        ),
      ),
    );
  }
}
