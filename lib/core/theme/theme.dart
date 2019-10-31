import 'package:flutter/material.dart';

class CoolSchoolTheme {
  static final ThemeData _themeData = ThemeData(primarySwatch: Colors.blue)
      .copyWith(textTheme: Typography.blackMountainView);

  static ThemeData get themeData => _themeData;
}
