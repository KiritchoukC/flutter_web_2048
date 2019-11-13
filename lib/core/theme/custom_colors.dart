import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._(); // this basically makes it so you can instantiate this class

  static const _primaryValue = 0xFFe7e5df;

  static const MaterialColor primaryColor = const MaterialColor(
    _primaryValue,
    const <int, Color>{
      50: const Color(0xFFfcfcfb),
      100: const Color(0xFFf8f7f5),
      200: const Color(0xFFf3f2ef),
      300: const Color(0xFFeeede9),
      400: const Color(0xFFebe9e4),
      500: const Color(_primaryValue),
      600: const Color(0xFFe4e2db),
      700: const Color(0xFFe0ded7),
      800: const Color(0xFFdddad2),
      900: const Color(0xFFd7d3ca),
    },
  );

  static const _accentColor = 0xFF48e5c2;

  static const MaterialColor accentColor = const MaterialColor(
    _accentColor,
    const <int, Color>{
      50: const Color(0xFFe9fcf8),
      100: const Color(0xFFc8f7ed),
      200: const Color(0xFFa4f2e1),
      300: const Color(0xFF7fedd4),
      400: const Color(0xFF63e9cb),
      500: const Color(_accentColor),
      600: const Color(0xFF41e2bc),
      700: const Color(0xFF38deb4),
      800: const Color(0xFF30daac),
      900: const Color(0xFF21d39f),
    },
  );
}