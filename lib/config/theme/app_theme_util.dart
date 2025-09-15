import 'package:flutter/material.dart';
import 'package:flutter_bump_app/config/theme/base_app_theme.dart';
import 'package:flutter_bump_app/config/theme/base_theme_data.dart';
import 'package:flutter_bump_app/config/theme/ecommerce/ecommerce_theme.dart';

class AppThemeUtil {
  final theme = EcommerceAppThemeDefault();

  final ValueNotifier<ThemeType> themeType = ValueNotifier(ThemeType.light);

  BaseAppTheme get appTheme => theme;

  void dispose() {
    themeType.dispose();
  }

  ThemeData getThemeData() {
    return theme.getThemeData(themeType.value);
  }

  BaseThemeData getAppTheme() {
    return theme.getBaseTheme(themeType.value);
  }

  onChangeLightDarkMode() {
    if (themeType.value == ThemeType.light) {
      themeType.value = ThemeType.dark;
    } else {
      themeType.value = ThemeType.light;
    }
  }
}
