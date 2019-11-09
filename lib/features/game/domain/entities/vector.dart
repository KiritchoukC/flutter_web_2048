import 'package:flutter_web_2048/core/enums/direction.dart';

class Vector{
  final int x;
  final int y;

  Vector(this.x, this.y);

  factory Vector.fromDirection(Direction direction){
    switch (direction) {
      case Direction.up: return Vector(0, -1);
      case Direction.right: return Vector(1, 0);
      case Direction.down: return Vector(0, 1);
      case Direction.left: return Vector(-1, 0);
      default:return Vector(0, 0);
    }
  }
}