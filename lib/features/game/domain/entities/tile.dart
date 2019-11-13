import 'package:flutter/material.dart';

import 'destination.dart';

class Tile {
  final int value;
  final int x;
  final int y;
  final int toXCell;
  final int toYCell;
  bool merged;

  Tile(this.value,
      {@required this.x,
      @required this.y,
      @required this.toXCell,
      @required this.toYCell,
      this.merged = false});

  factory Tile.fromDirection(int value, int x, int y, Destination destination) {
    if (destination.hasMerged) {
      return Tile(
        value * 2,
        x: destination.x,
        y: destination.y,
        toXCell: destination.mergedWith.x,
        toYCell: destination.mergedWith.y,
        merged: true,
      );
    } else {
      return Tile(
        value,
        x: destination.x,
        y: destination.y,
        toXCell: x,
        toYCell: y,
        merged: false,
      );
    }
  }
}
