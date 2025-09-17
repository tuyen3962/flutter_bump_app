import 'package:flutter/material.dart';

abstract class BaseThemeData {
  Color get primaryColor => yellow500;
  Color get dividerColor => blue500;
  Color get hintColor => blue500;
  Color get backgroundContainer => blue500;
  Color get background => alpha;
  Color get fadeTextColor => blue500;
  Color get fadeBackgroundColor => blue500;
  Color get primaryTextColor => Colors.white;
  Color get secondaryTextColor => Colors.black;
  Color get borderColor => Colors.black;
  Color get errorColor => Colors.red;
  Color get backgroundTextField => Colors.black;

  Color get whiteText => Colors.white;
  Color get blackColor => Colors.black;

  Color get appColor => Color(0xFF2979FF);
  Color get transparentColor => Colors.transparent;

  Color alpha = const Color(0xFFFFFFFF);
  Color get alpha4 => alpha.withValues(alpha: 0.04);
  Color get alpha8 => alpha.withValues(alpha: 0.08);
  Color get alpha16 => alpha.withValues(alpha: 0.16);
  Color get alpha24 => alpha.withValues(alpha: 0.24);
  Color get alpha32 => alpha.withValues(alpha: 0.32);
  Color get alpha40 => alpha.withValues(alpha: 0.40);
  Color get alpha48 => alpha.withValues(alpha: 0.48);
  Color get alpha64 => alpha.withValues(alpha: 0.64);
  Color get alpha80 => alpha.withValues(alpha: 0.80);

  // Extended Color Palette - Yellow/Amber Series
  Color yellow100 = const Color(0xFFFFF9C4);
  Color yellow200 = const Color(0xFFFFF59D);
  Color yellow300 = const Color(0xFFFFF176);
  Color yellow400 = const Color(0xFFFFEE58);
  Color yellow500 = const Color(0xFFFFEB3B);
  Color yellow600 = const Color(0xFFFDD835);
  Color yellow700 = const Color(0xFFFBC02D);
  Color yellow800 = const Color(0xFFF9A825);
  Color yellow900 = const Color(0xFFF57F17);

  // Extended Color Palette - Amber Series
  Color amber100 = const Color(0xFFFFECB3);
  Color amber200 = const Color(0xFFFFE082);
  Color amber300 = const Color(0xFFFFD54F);
  Color amber400 = const Color(0xFFFFCA28);
  Color amber500 = const Color(0xFFFFC107);
  Color amber600 = const Color(0xFFFFB300);
  Color amber700 = const Color(0xFFFFA000);
  Color amber800 = const Color(0xFFFF8F00);
  Color amber900 = const Color(0xFFFF6F00);

  // Extended Color Palette - Brown Series
  Color brown100 = const Color(0xFFD7CCC8);
  Color brown200 = const Color(0xFFBCAAA4);
  Color brown300 = const Color(0xFFA1887F);
  Color brown400 = const Color(0xFF8D6E63);
  Color brown500 = const Color(0xFF795548);
  Color brown600 = const Color(0xFF6D4C41);
  Color brown700 = const Color(0xFF5D4037);
  Color brown800 = const Color(0xFF4E342E);
  Color brown900 = const Color(0xFF3E2723);

  // Extended Color Palette - Gray Series (Additional)
  Color gray50 = const Color(0xFFFAFAFA);
  Color gray100 = const Color(0xFFF5F5F5);
  Color gray200 = const Color(0xFFEEEEEE);
  Color gray300 = const Color(0xFFE0E0E0);
  Color gray400 = const Color(0xFFBDBDBD);
  Color gray500 = const Color(0xFF9E9E9E);
  Color gray600 = const Color(0xFF757575);
  Color gray700 = const Color(0xFF616161);
  Color gray800 = const Color(0xFF424242);
  Color gray900 = const Color(0xFF212121);

  // Extended Color Palette - Green Series (Additional)
  Color green50 = const Color(0xFFE8F5E8);
  Color green100 = const Color(0xFFC8E6C9);
  Color green200 = const Color(0xFFA5D6A7);
  Color green300 = const Color(0xFF81C784);
  Color green400 = const Color(0xFF66BB6A);
  Color green500 = const Color(0xFF4CAF50);
  Color green600 = const Color(0xFF43A047);
  Color green700 = const Color(0xFF388E3C);
  Color green800 = const Color(0xFF2E7D32);
  Color green900 = const Color(0xFF1B5E20);

  // Extended Color Palette - Blue Series (Additional)
  Color blue50 = const Color(0xFFE3F2FD);
  Color blue100 = const Color(0xFFBBDEFB);
  Color blue200 = const Color(0xFF90CAF9);
  Color blue300 = const Color(0xFF64B5F6);
  Color blue400 = const Color(0xFF42A5F5);
  Color blue500 = const Color(0xFF2196F3);
  Color blue600 = const Color(0xFF1E88E5);
  Color blue700 = const Color(0xFF1976D2);
  Color blue800 = const Color(0xFF1565C0);
  Color blue900 = const Color(0xFF0D47A1);

  // Extended Color Palette - Red Series (Additional)
  Color red50 = const Color(0xFFFFEBEE);
  Color red100 = const Color(0xFFFFCDD2);
  Color red200 = const Color(0xFFEF9A9A);
  Color red300 = const Color(0xFFE57373);
  Color red400 = const Color(0xFFEF5350);
  Color red500 = const Color(0xFFF44336);
  Color red600 = const Color(0xFFE53935);
  Color red700 = const Color(0xFFD32F2F);
  Color red800 = const Color(0xFFC62828);
  Color red900 = const Color(0xFFB71C1C);
}
