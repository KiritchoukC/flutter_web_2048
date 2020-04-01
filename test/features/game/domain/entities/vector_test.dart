import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/vector.dart';

void main() {
  group('getVector', () {
    test('should return (0,-1) for up direction', () {
      // ARRANGE
      final expected = Vector(0, -1);
      const direction = Direction.up;

      // ACT
      final actual = Vector.fromDirection(direction);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
    test('should return (0,1) for down direction', () {
      // ARRANGE
      final expected = Vector(0, 1);
      const direction = Direction.down;

      // ACT
      final actual = Vector.fromDirection(direction);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
    test('should return (-1,0) for left direction', () {
      // ARRANGE
      final expected = Vector(-1, 0);
      const direction = Direction.left;

      // ACT
      final actual = Vector.fromDirection(direction);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
    test('should return (1,0) for right direction', () {
      // ARRANGE
      final expected = Vector(1, 0);
      const direction = Direction.right;

      // ACT
      final actual = Vector.fromDirection(direction);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
    test('should return (0,0) for no direction', () {
      // ARRANGE
      final expected = Vector(0, 0);

      // ACT
      final actual = Vector.fromDirection(null);
      // ASSERT
      expect(actual.x, expected.x);
      expect(actual.y, expected.y);
    });
  });
}
