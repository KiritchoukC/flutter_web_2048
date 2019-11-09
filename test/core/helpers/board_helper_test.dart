import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/core/helpers/board_helper.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

void main() {
  group('getEmptyTiles', () {
    test("should have a length of 16 for a blank board", () {
      // ARRANGE
      var tiles = List<List<Tile>>.generate(4, (y) => List(4));
      var board = Board(tiles);
      // ACT
      var actual = BoardHelper.getEmptyTiles(board);
      // ASSERT
      expect(actual.length, 16);
    });

    test("should return indices from 0 to 15 for a blank board", () {
      // ARRANGE
      var expected = [
        {'x': 0, 'y': 0},
        {'x': 1, 'y': 0},
        {'x': 2, 'y': 0},
        {'x': 3, 'y': 0},
        {'x': 0, 'y': 1},
        {'x': 1, 'y': 1},
        {'x': 2, 'y': 1},
        {'x': 3, 'y': 1},
        {'x': 0, 'y': 2},
        {'x': 1, 'y': 2},
        {'x': 2, 'y': 2},
        {'x': 3, 'y': 2},
        {'x': 0, 'y': 3},
        {'x': 1, 'y': 3},
        {'x': 2, 'y': 3},
        {'x': 3, 'y': 3}
      ];
      var tiles = List<List<Tile>>.generate(4, (y) => List(4));
      var board = Board(tiles);
      // ACT
      var actual = BoardHelper.getEmptyTiles(board);
      // ASSERT
      expect(actual.toList(), expected);
    });

    test("should have a length of 14 for an initial board", () {
      // ARRANGE
      var tiles = List<List<Tile>>.generate(4, (y) => List(4));
      tiles[2][3] = Tile(2, x: 2, y: 3);
      tiles[3][3] = Tile(2, x: 3, y: 3);
      var board = Board(tiles);
      // ACT
      var actual = BoardHelper.getEmptyTiles(board);
      // ASSERT
      expect(actual.length, 14);
    });

    test("should have a length of 0 for a full board", () {
      // ARRANGE
      var tiles =
          List<List<Tile>>.generate(4, (y) => List<Tile>.generate(4, (x) => Tile(2, x: x, y: y)));
      var board = Board(tiles);
      // ACT
      var actual = BoardHelper.getEmptyTiles(board);
      // ASSERT
      expect(actual.length, 0);
    });

    test("should return 0 index for a full board", () {
      // ARRANGE
      var expected = List<Map<String, int>>();
      var tiles =
          List<List<Tile>>.generate(4, (y) => List<Tile>.generate(4, (x) => Tile(2, x: x, y: y)));
      var board = Board(tiles);
      // ACT
      var actual = BoardHelper.getEmptyTiles(board);
      // ASSERT
      expect(actual.toList(), expected);
    });
  });

  group('getVector', () {
    test('should return x:0 & y:-1 for up direction', () {
      // ARRANGE
      var expected = {'x': 0, 'y': -1};
      var direction = Direction.up;

      // ACT
      var actual = BoardHelper.getVector(direction);
      // ASSERT
      expect(actual, expected);
    });
    test('should return x:0 & y:1 for down direction', () {
      // ARRANGE
      var expected = {'x': 0, 'y': 1};
      var direction = Direction.down;

      // ACT
      var actual = BoardHelper.getVector(direction);
      // ASSERT
      expect(actual, expected);
    });
    test('should return x:-1 & y:0 for left direction', () {
      // ARRANGE
      var expected = {'x': -1, 'y': 0};
      var direction = Direction.left;

      // ACT
      var actual = BoardHelper.getVector(direction);
      // ASSERT
      expect(actual, expected);
    });
    test('should return x:1 & y:0 for right direction', () {
      // ARRANGE
      var expected = {'x': 1, 'y': 0};
      var direction = Direction.right;

      // ACT
      var actual = BoardHelper.getVector(direction);
      // ASSERT
      expect(actual, expected);
    });
  });

  group('getTraversals', () {
    test('should return traversals from top left to bottom right when moving left', () {
      // ARRANGE
      var expected = {
        'x': <int>[0, 1, 2, 3], // from left to right
        'y': <int>[0, 1, 2, 3] // from top to bottom
      };

      var vector = {'x': -1, 'y': 0}; // moving left
      int size = 4;

      // ACT
      var actual = BoardHelper.getTraversals(vector, size);

      // ASSERT
      expect(actual, expected);
    });
    test('should return traversals from top right to bottom left when moving right', () {
      // ARRANGE
      var expected = {
        'x': <int>[3, 2, 1, 0], // from right to left
        'y': <int>[0, 1, 2, 3] // from top to bottom
      };

      var vector = {'x': 1, 'y': 0}; // moving right
      int size = 4;

      // ACT
      var actual = BoardHelper.getTraversals(vector, size);

      // ASSERT
      expect(actual, expected);
    });
    test('should return traversals from bottom left to top right when moving down', () {
      // ARRANGE
      var expected = {
        'x': <int>[0, 1, 2, 3], // from right to left
        'y': <int>[3, 2, 1, 0] // from top to bottom
      };

      var vector = {'x': 0, 'y': 1}; // moving down
      int size = 4;

      // ACT
      var actual = BoardHelper.getTraversals(vector, size);

      // ASSERT
      expect(actual, expected);
    });
    test('should return traversals from top left to bottom right when moving up', () {
      // ARRANGE
      var expected = {
        'x': <int>[0, 1, 2, 3], // from right to left
        'y': <int>[0, 1, 2, 3] // from top to bottom
      };

      var vector = {'x': 0, 'y': -1}; // moving up
      int size = 4;

      // ACT
      var actual = BoardHelper.getTraversals(vector, size);

      // ASSERT
      expect(actual, expected);
    });
  });
}
