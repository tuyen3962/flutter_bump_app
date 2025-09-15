import 'package:flutter/material.dart';

class BasePalettes {
  Color primary500 = const Color(0xFF5B2406);
  Color primary400 = const Color(0xFFE55A0F);
  Color primary300 = const Color(0xFFF27836);
  Color primary200 = const Color(0xFFF59B6B);
  Color primary100 = const Color(0xFFFCDFCF);
  Color primary50 = const Color(0xFFFFF6F0);

  Color secondary50 = const Color(0xFFE7F5E9);
  Color secondary100 = const Color(0xFFD6FFEA);
  Color secondary200 = const Color(0xFFADFFD6);
  Color secondary300 = const Color(0xFF1B8024);
  Color secondary400 = const Color(0xFF006B35);
  Color secondary500 = const Color(0xFF002914);

  Color neutral700 = const Color(0xFF0F1729);
  Color neutral600 = const Color(0xFF48546B);
  Color neutral500 = const Color(0xFF7987A4);
  Color neutral400 = const Color(0xFF94A3B8);
  Color neutral300 = const Color(0xFFCBD5E1);
  Color neutral200 = const Color(0xFFEDF0F5);
  Color neutral100 = const Color(0xFFF0F3F9);
  Color neutral000 = const Color(0xFFFFFFFF);

  Color success500 = const Color(0xFF115217);
  Color success400 = const Color(0xFF15661D);
  Color success300 = const Color(0xFF1B8024);
  Color success200 = const Color(0xFFC4F3CE);
  Color success100 = const Color(0xFFE7F5E9);

  Color warning500 = const Color(0xFF702700);
  Color warning400 = const Color(0xFFA94302);
  Color warning300 = const Color(0xFFCE5B05);
  Color warning200 = const Color(0xFFFED0A3);
  Color warning100 = const Color(0xFFFFF5EB);

  Color danger500 = const Color(0xFF710010);
  Color danger400 = const Color(0xFFA32121);
  Color danger300 = const Color(0xFFCD3031);
  Color danger200 = const Color(0xFFF5C6C2);
  Color danger100 = const Color(0xFFFEEDEB);

  Color info500 = const Color(0xFF003F70);
  Color info400 = const Color(0xFF00508F);
  Color info300 = const Color(0xFF0067B8);
  Color info200 = const Color(0xFFBBD6FF);
  Color info100 = const Color(0xFFE1F5FE);

  Color alphaWhite = const Color(0xFFFFFFFF);
  Color get alphaWhite4 => alphaWhite.withValues(alpha: 0.04);
  Color get alphaWhite8 => alphaWhite.withValues(alpha: 0.08);
  Color get alphaWhite16 => alphaWhite.withValues(alpha: 0.16);
  Color get alphaWhite24 => alphaWhite.withValues(alpha: 0.24);
  Color get alphaWhite32 => alphaWhite.withValues(alpha: 0.32);
  Color get alphaWhite40 => alphaWhite.withValues(alpha: 0.40);
  Color get alphaWhite48 => alphaWhite.withValues(alpha: 0.48);
  Color get alphaWhite64 => alphaWhite.withValues(alpha: 0.64);
  Color get alphaWhite80 => alphaWhite.withValues(alpha: 0.80);

  Color alphaBlack = const Color(0xFF000819);
  Color get alphaBlack4 => alphaBlack.withValues(alpha: 0.04);
  Color get alphaBlack8 => alphaBlack.withValues(alpha: 0.08);
  Color get alphaBlack16 => alphaBlack.withValues(alpha: 0.16);
  Color get alphaBlack24 => alphaBlack.withValues(alpha: 0.24);
  Color get alphaBlack32 => alphaBlack.withValues(alpha: 0.32);
  Color get alphaBlack40 => alphaBlack.withValues(alpha: 0.40);
  Color get alphaBlack48 => alphaBlack.withValues(alpha: 0.48);
  Color get alphaBlack64 => alphaBlack.withValues(alpha: 0.64);
  Color get alphaBlack80 => const Color(0xFF000000).withValues(alpha: 0.80);

  // Component specific colors
  Color rating = const Color(0xFFFFAE10);

  // Brand Colors
  Color orangeSub = const Color(0xFFDA3602);
  Color orangeMain = const Color(0xFFE55A0F);
  Color greenMain = const Color(0xFF006B35);

  // Grey Scale
  Color grey900 = const Color(0xFF0F1729);
  Color grey800 = const Color(0xFF48546B);
  Color grey700 = const Color(0xFF7987A4);
  Color grey600 = const Color(0xFF94A3B8);
  Color grey500 = const Color(0xFFCBD5E1);
  Color grey400 = const Color(0xFFEEF3F6);
  Color grey300 = const Color(0xFFF4F8FC);
  Color grey200 = const Color(0xFFF0F3F9);
  Color grey100 = const Color(0xFFF1F5F8);
  Color grey000 = const Color(0xFFFFFFFF);

  // State / Success
  Color successG200 = const Color(0xFF1E9037);
  Color successG300 = const Color(0xFF135A19);
  Color successG100 = const Color(0xFFE7F5E9);

  // State / Warning
  Color warningY300P = const Color(0xFFE65000);
  Color warningY200 = const Color(0xFFFFAE10);
  Color warningY100 = const Color(0xFFF6F2E9);

  // State / Dangerous
  Color dangerousR300 = const Color(0xFFC62828);
  Color dangerousR200 = const Color(0xFFF80024);
  Color dangerousR100 = const Color(0xFFE55B4F);
  Color dangerousR50 = const Color(0xFFFEEDEB);

  // State / Info
  Color stateInfoB300P = const Color(0xFF00579B);
  Color stateInfoB200 = const Color(0xFF2381FF);
  Color stateInfoB100 = const Color(0xFFE1F5FE);

  // Alpha (White with opacity)
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

class NormalPalettes extends BasePalettes {}

class WalletPalettes extends BasePalettes {
  @override
  Color get primary500 => Color(0xFFDA3602);
  @override
  Color get primary300 => Color(0xFFFF8746);
  @override
  Color get primary200 => Color(0xFFFF8746);
  @override
  Color get primary100 => Color(0xFFFF8746);

  @override
  Color get secondary50 => Color(0xFFE6F0FD);
  @override
  Color get secondary300 => Color(0xFF00BD5D);

  @override
  Color get warning400 => Color(0xFFC74500);
  @override
  Color get warning300 => Color(0xFFE65000);
  @override
  Color get warning200 => Color(0xFFFFE7B8);
  @override
  Color get warning100 => Color(0xFFF6F2E9);

  @override
  Color get alphaBlack => Color(0xFF000000);
}
