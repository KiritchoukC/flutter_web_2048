import 'package:flutter/material.dart';

import 'custom_colors.dart';

class CustomTheme {
  static final ThemeData _themeData = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: CustomColors.primaryColor,
    primaryColorBrightness: Brightness.dark,
    accentColor: CustomColors.accentColor[500],
    accentColorBrightness: Brightness.dark,
  ).copyWith(textTheme: Typography.blackMountainView);

  static ThemeData get themeData => _themeData;
}
