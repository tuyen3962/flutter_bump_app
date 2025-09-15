import 'package:flutter/material.dart';
import 'package:flutter_bump_app/widget/image_asset_custom.dart';

class ObscurePasswordIcon extends StatelessWidget {
  const ObscurePasswordIcon({
    super.key,
    this.onTap,
    this.isObscure = false,
  });

  final bool isObscure;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ImageAssetCustom(
        imagePath: '',
        // imagePath: !isObscure
        //     ? Assets.icons.visible.path
        //     : Assets.icons.unvisible.path,
        size: 20,
      ),
    );
  }
}
