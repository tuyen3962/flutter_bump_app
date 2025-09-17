import 'package:flutter/material.dart';
import 'package:flutter_bump_app/extension.dart';

extension BuildContextExt on BuildContext {
  void hideKeyboard() {
    FocusNode node = FocusScope.of(this);
    if (!node.hasPrimaryFocus) {
      node.unfocus();
    }
  }

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;
}

extension WidgetExt on Widget {
  Widget pad({
    double? horizontal,
    double? vertical,
    double? all,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) =>
      Padding(
          padding: padding(
              left: left ?? all ?? horizontal,
              right: right ?? all ?? horizontal,
              top: top ?? all ?? vertical,
              bottom: bottom ?? all ?? vertical),
          child: this);

  Widget get expand => Expanded(child: this);

  Widget expandFlex(int flex) => Expanded(flex: flex, child: this);
}
