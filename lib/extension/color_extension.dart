import 'dart:ui';

extension SafeOpacityExtension on Color {
  Color withSafeOpacity(double opacity) {
    assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1.');
    return withAlpha((opacity * 255).round());
  }
}

extension HexColorExtension on String {
  Color get toColor {
    final hex = replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }
}
