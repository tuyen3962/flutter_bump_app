import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoading() {
  EasyLoading.show(
    status: 'loading',
    maskType: EasyLoadingMaskType.black,
  );
}

void dismissLoading() {
  EasyLoading.dismiss();
}

Future<T?> handleInLoading<T>(Future<T> Function() function,
    {VoidCallback? optionHandleDataFail}) async {
  try {
    showLoading();
    final result = await function();
    dismissLoading();
    return result;
  } catch (e) {
    dismissLoading();
    if (optionHandleDataFail != null) {
      optionHandleDataFail();
    }
    rethrow;
  }
}
