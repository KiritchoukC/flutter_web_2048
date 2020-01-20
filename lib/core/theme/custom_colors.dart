import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._(); // this basically makes it so you can instantiate this class

  static const _primaryValue = 0xFFe7e5df;

  static const MaterialColor primaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFfcfcfb),
      100: Color(0xFFf8f7f5),
      200: Color(0xFFf3f2ef),
      300: Color(0xFFeeede9),
      400: Color(0xFFebe9e4),
      500: Color(_primaryValue),
      600: Color(0xFFe4e2db),
      700: Color(0xFFe0ded7),
      800: Color(0xFFdddad2),
      900: Color(0xFFd7d3ca),
    },
  );

  static const _accentColor = 0xFF48e5c2;

  static const MaterialColor accentColor = MaterialColor(
    _accentColor,
    <int, Color>{
      50: Color(0xFFe9fcf8),
      100: Color(0xFFc8f7ed),
      200: Color(0xFFa4f2e1),
      300: Color(0xFF7fedd4),
      400: Color(0xFF63e9cb),
      500: Color(_accentColor),
      600: Color(0xFF41e2bc),
      700: Color(0xFF38deb4),
      800: Color(0xFF30daac),
      900: Color(0xFF21d39f),
    },
  );
}
