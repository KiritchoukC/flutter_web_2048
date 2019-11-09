import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/domain/entities/traversal.dart';
import 'package:flutter_web_2048/features/game/domain/entities/vector.dart';

void main() {
  group('fromVector', () {
    test('should return traversals from top left to bottom right when moving left', () {
      // ARRANGE
      var expected = Traversal(x: <int>[0, 1, 2, 3], y: <int>[0, 1, 2, 3]);

      var vector = Vector(-1, 0); // moving left
      int size = 4;

      // ACT
      var actual = Traversal.fromVector(vector, size);

      // ASSERT
      expect(actual.y, expected.y);
      expect(actual.x, expected.x);
    });
    test('should return traversals from top right to bottom left when moving right', () {
      // ARRANGE
      var expected = Traversal(x: <int>[3, 2, 1, 0], y: <int>[0, 1, 2, 3]);

      var vector = Vector(1, 0); // moving right
      int size = 4;

      // ACT
      var actual = Traversal.fromVector(vector, size);

      // ASSERT
      expect(actual.y, expected.y);
      expect(actual.x, expected.x);
    });
    test('should return traversals from bottom left to top right when moving down', () {
      // ARRANGE
      var expected = Traversal(x: <int>[0, 1, 2, 3], y: <int>[3, 2, 1, 0] );

      var vector = Vector(0, 1); // moving down
      int size = 4;

      // ACT
      var actual = Traversal.fromVector(vector, size);

      // ASSERT
      expect(actual.y, expected.y);
      expect(actual.x, expected.x);
    });
    test('should return traversals from top left to bottom right when moving up', () {
      // ARRANGE
      var expected = Traversal(x: <int>[0, 1, 2, 3], y: <int>[0, 1, 2, 3]);

      var vector = Vector(0, -1); // moving up
      int size = 4;

      // ACT
      var actual = Traversal.fromVector(vector, size);

      // ASSERT
      expect(actual.y, expected.y);
      expect(actual.x, expected.x);
    });
  });
}
