import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/main.dart';

class CircleItem extends StatelessWidget {
  const CircleItem({
    super.key,
    required this.child,
    this.backgroundColor,
    this.size,
    this.margin,
    this.padding,
    this.onTap,
    this.borderColor,
    this.borderWidth,
    this.isCircle = true,
  });

  final double? size;
  final Color? backgroundColor;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double? borderWidth;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: Container(
            width: size?.w,
            height: size?.w,
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                color: backgroundColor ?? appTheme.whiteText,
                border: (borderWidth ?? 0) > 1
                    ? Border.all(
                        color: borderColor ?? appTheme.whiteText,
                        width: borderWidth ?? 0)
                    : null),
            child: child),
      ),
    );
  }
}
