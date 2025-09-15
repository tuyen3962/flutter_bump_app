import 'package:flutter/material.dart';

class ResizeView extends StatelessWidget {
  const ResizeView({
    super.key,
    this.size,
    this.child,
  });

  final double? size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, width: size, child: child);
  }
}
