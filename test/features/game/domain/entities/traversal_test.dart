import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/domain/entities/traversal.dart';
import 'package:flutter_web_2048/features/game/domain/entities/vector.dart';

void main() {
  group('fromVector', () {
    test('should return traversals from top left to bottom right when moving left', () {
      // ARRANGE
      final expected = Traversal(x: <int>[0, 1, 2, 3], y: <int>[0, 1, 2, 3]);

      final vector = Vector(-1, 0); // moving left
      const int size = 4;

      // ACT
      final actual = Traversal.fromVector(vector, size);

      // ASSERT
      expect(actual.y, expected.y);
      expect(actual.x, expected.x);
    });
    test('should return traversals from top right to bottom left when moving right', () {
      // ARRANGE
      final expected = Traversal(x: <int>[3, 2, 1, 0], y: <int>[0, 1, 2, 3]);

      final vector = Vector(1, 0); // moving right
      const int size = 4;

      // ACT
      final actual = Traversal.fromVector(vector, size);

      // ASSERT
      expect(actual.y, expected.y);
      expect(actual.x, expected.x);
    });
    test('should return traversals from bottom left to top right when moving down', () {
      // ARRANGE
      final expected = Traversal(x: <int>[0, 1, 2, 3], y: <int>[3, 2, 1, 0]);

      final vector = Vector(0, 1); // moving down
      const int size = 4;

      // ACT
      final actual = Traversal.fromVector(vector, size);

      // ASSERT
      expect(actual.y, expected.y);
      expect(actual.x, expected.x);
    });
    test('should return traversals from top left to bottom right when moving up', () {
      // ARRANGE
      final expected = Traversal(x: <int>[0, 1, 2, 3], y: <int>[0, 1, 2, 3]);

      final vector = Vector(0, -1); // moving up
      const int size = 4;

      // ACT
      final actual = Traversal.fromVector(vector, size);

      // ASSERT
      expect(actual.y, expected.y);
      expect(actual.x, expected.x);
    });
  });
}
