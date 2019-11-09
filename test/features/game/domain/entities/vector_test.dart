import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/vector.dart';

void main() {
  group('getVector', () {
    test('should return (0,-1) for up direction', () {
      // ARRANGE
      var expected = Vector(0, -1);
      var direction = Direction.up;

      // ACT
      var actual = Vector.fromDirection(direction);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
    test('should return (0,1) for down direction', () {
      // ARRANGE
      var expected = Vector(0, 1);
      var direction = Direction.down;

      // ACT
      var actual = Vector.fromDirection(direction);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
    test('should return (-1,0) for left direction', () {
      // ARRANGE
      var expected = Vector(-1, 0);
      var direction = Direction.left;

      // ACT
      var actual = Vector.fromDirection(direction);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
    test('should return (1,0) for right direction', () {
      // ARRANGE
      var expected = Vector(1, 0);
      var direction = Direction.right;

      // ACT
      var actual = Vector.fromDirection(direction);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
  });
}
