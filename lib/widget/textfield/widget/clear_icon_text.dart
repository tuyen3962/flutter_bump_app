import 'package:flutter/material.dart';

class ClearIconText extends StatelessWidget {
  const ClearIconText(
      {super.key, this.controller, this.text = '', this.handleAfterClear});

  final String? text;
  final TextEditingController? controller;
  final VoidCallback? handleAfterClear;

  @override
  Widget build(BuildContext context) {
    final icon = GestureDetector(
      onTap: () {
        if (controller != null) {
          controller?.text = '';
        }
        handleAfterClear?.call();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Assets.icons.closeFill.svg(width: 20.w, height: 20.w),
        ],
      ),
    );
    if (controller != null) {
      return ValueListenableBuilder(
          valueListenable: controller!,
          builder: (_, textCtrl, __) =>
              Visibility(visible: textCtrl.text.isNotEmpty, child: icon));
    }
    return Visibility(visible: text?.isNotEmpty ?? false, child: icon);
  }
}
