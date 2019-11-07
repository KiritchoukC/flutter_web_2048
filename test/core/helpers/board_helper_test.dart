import 'package:flutter_test/flutter_test.dart';
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
}
