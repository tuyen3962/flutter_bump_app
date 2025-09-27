import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';
import 'package:flutter_bump_app/extension/color_extension.dart';
import 'package:flutter_bump_app/main.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({
    this.width,
    this.height,
    this.color,
    super.key,
    this.margin,
  });

  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width?.w ?? double.infinity,
      height: height?.h ?? 1.h,
      color: color ?? appTheme.green300.withSafeOpacity(0.5),
    );
  }
}
