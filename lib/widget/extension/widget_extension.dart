import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';

extension WidgetExtension on Widget {
  Widget buildGradient({Gradient? gradient}) => gradient == null
      ? this
      : ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (rect) => gradient
              .createShader(Rect.fromLTWH(0, 0, rect.width, rect.height)),
          child: this,
        );

  Widget clickable({VoidCallback? onTap, HitTestBehavior? behavior}) =>
      GestureDetector(
          onTap: onTap,
          behavior: behavior ?? HitTestBehavior.opaque,
          child: this);

  Widget clickPop(BuildContext context, {HitTestBehavior? behavior}) =>
      GestureDetector(
          onTap: context.maybePop,
          behavior: behavior ?? HitTestBehavior.opaque,
          child: this);

  Widget rotate({double? angle}) =>
      Transform.rotate(angle: angle ?? 0, child: this);

  Widget space(
          {double? horizontal,
          double? vertical,
          double? all,
          double? left,
          double? right,
          double? top,
          double? bottom}) =>
      Padding(
          padding: padding(
              horizontal: horizontal,
              vertical: vertical,
              all: all,
              left: left,
              right: right,
              top: top,
              bottom: bottom),
          child: this);

  Widget expand() => Expanded(child: this);

  Widget unFocus(BuildContext context) => GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: this);
}

extension NumberWidgetExtension on num {
  Widget get height => SizedBox(height: this.toDouble());

  Widget get width => SizedBox(width: this.toDouble());
}
