import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  void hideKeyboard() {
    FocusNode node = FocusScope.of(this);
    if (!node.hasPrimaryFocus) {
      node.unfocus();
    }
  }

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;
}
