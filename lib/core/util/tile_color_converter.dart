import 'package:flutter/material.dart';

import '../theme/custom_colors.dart';

Color mapTileValueToColor(int value) => value == null ? _colors[0] : _colors[value];

Map<int, Color> _colors = {
  0: Colors.grey.shade900,
  2: CustomColors.accentColor.shade50,
  4: CustomColors.accentColor.shade100,
  8: CustomColors.accentColor.shade200,
  16: CustomColors.accentColor.shade300,
  32: CustomColors.accentColor.shade400,
  64: CustomColors.accentColor.shade500,
  128: CustomColors.accentColor.shade600,
  256: CustomColors.accentColor.shade700,
  512: CustomColors.accentColor.shade800,
  1024: CustomColors.accentColor.shade900,
  2048: Colors.red.shade200,
  4096: Colors.red.shade300,
  8192: Colors.red.shade400,
  16384: Colors.red.shade500,
  32768: Colors.red.shade600,
  65536: Colors.red.shade700,
};
