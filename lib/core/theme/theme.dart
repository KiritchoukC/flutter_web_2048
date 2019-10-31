import 'package:flutter/material.dart';

class CustomTheme {
  static final ThemeData _themeData = ThemeData(primarySwatch: Colors.blue)
      .copyWith(textTheme: Typography.blackMountainView);

  static ThemeData get themeData => _themeData;
}
