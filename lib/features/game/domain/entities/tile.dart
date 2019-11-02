import 'package:flutter/material.dart';

class Tile{
  final int value;
  Color get color => ColorValue.colors[value];

  Tile({@required this.value});
}

class ColorValue{
  static Map<int, Color> colors = {
    0: Colors.grey.shade100,
    2: Colors.blue.shade100,
    4: Colors.blue.shade200,
    8: Colors.blue.shade300,
    16: Colors.blue.shade400,
    32: Colors.blue.shade500,
    64: Colors.blue.shade600,
    128: Colors.blue.shade700,
    256: Colors.blue.shade800,
    512: Colors.blue.shade900,
    1024: Colors.red.shade100,
    2048: Colors.red.shade200,
    4096: Colors.red.shade300,
    8192: Colors.red.shade400,
    16384: Colors.red.shade500,
    32768: Colors.red.shade600,
    65536: Colors.red.shade700,
  };
}