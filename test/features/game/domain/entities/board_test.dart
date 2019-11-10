import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/coordinate.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/entities/vector.dart';

void main() {
  group('getEmptyTiles', () {
    test("should have a length of 16 for a blank board", () {
      // ARRANGE
      var tiles = List<List<Tile>>.generate(4, (y) => List(4));
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyTileCoordinates();
      // ASSERT
      expect(actual.length, 16);
    });

    test("should return all coordinates for a blank board", () {
      // ARRANGE
      var expected = [
        Coordinate(0, 0),
        Coordinate(1, 0),
        Coordinate(2, 0),
        Coordinate(3, 0),
        Coordinate(0, 1),
        Coordinate(1, 1),
        Coordinate(2, 1),
        Coordinate(3, 1),
        Coordinate(0, 2),
        Coordinate(1, 2),
        Coordinate(2, 2),
        Coordinate(3, 2),
        Coordinate(0, 3),
        Coordinate(1, 3),
        Coordinate(2, 3),
        Coordinate(3, 3)
      ];

      var tiles = List<List<Tile>>.generate(4, (y) => List(4));
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyTileCoordinates().toList();
      // ASSERT
      expect(actual.length, 16);
      for (var i = 0; i < 16; i++) {
        var actualCoordinate = actual[i];
        var expectedCoordinate = expected[i];
        expect(actualCoordinate.x, expectedCoordinate.x);
        expect(actualCoordinate.y, expectedCoordinate.y);
      }
    });

    test("should have a length of 14 for an initial board", () {
      // ARRANGE
      var tiles = List<List<Tile>>.generate(4, (y) => List(4));
      tiles[2][3] = Tile(2, x: 2, y: 3);
      tiles[3][3] = Tile(2, x: 3, y: 3);
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyTileCoordinates();
      // ASSERT
      expect(actual.length, 14);
    });

    test("should have a length of 0 for a full board", () {
      // ARRANGE
      var tiles =
          List<List<Tile>>.generate(4, (y) => List<Tile>.generate(4, (x) => Tile(2, x: x, y: y)));
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyTileCoordinates();
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
      var actual = board.getEmptyTileCoordinates();
      // ASSERT
      expect(actual.toList(), expected);
    });
  });

  group('getTileDestination', () {
    group('no move', () {
      test('should return same position if tile does not move (left)', () {
        // ARRANGE
        var vector = Vector(-1, 0);

        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles[x][y] = tile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should return same position if tile does not move (right)', () {
        // ARRANGE
        var vector = Vector(1, 0);

        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        int x = 3;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles[x][y] = tile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should return same position if tile does not move (up)', () {
        // ARRANGE
        var vector = Vector(0, -1);

        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles[x][y] = tile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should return same position if tile does not move (down)', () {
        // ARRANGE
        var vector = Vector(0, 1);

        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        int x = 0;
        int y = 3;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles[x][y] = tile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });
    });
    group('move all the way', () {
      test('should move all the way to the right', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(1, 0);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles[x][y] = tile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 3);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should move all the way to the left', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(-1, 0);

        int x = 3;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles[x][y] = tile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 0);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should move all the way down', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(0, 1);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles[x][y] = tile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 3);
        expect(actual.hasMerged, false);
      });

      test('should move all the way up', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(0, -1);

        int x = 0;
        int y = 3;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles[x][y] = tile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 0);
        expect(actual.hasMerged, false);
      });
    });
    group('move with blocking tile', () {
      test('should move up until blocked by another tile with a different value', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(0, -1);

        int x = 0;
        int y = 3;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(4, x: 0, y: 0);

        // Starting board
        // |4|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |2|0|0|0|

        // Ending board
        // |4|0|0|0|
        // |2|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // put the tiles in the board
        board.tiles[x][y] = tile;
        board.tiles[0][0] = blockingTile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 1);
        expect(actual.hasMerged, false);
      });

      test('should move down until blocked by another tile with a different value', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(0, 1);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(4, x: 0, y: 3);

        // Starting board
        // |2|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |4|0|0|0|

        // Ending board
        // |0|0|0|0|
        // |0|0|0|0|
        // |2|0|0|0|
        // |4|0|0|0|

        // put the tiles in the board
        board.tiles[x][y] = tile;
        board.tiles[0][3] = blockingTile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 2);
        expect(actual.hasMerged, false);
      });

      test('should move to the right until blocked by another tile with a different value', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(1, 0);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(4, x: 3, y: 0);

        // Starting board
        // |2|0|0|4|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // Ending board
        // |0|0|2|4|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // put the tiles in the board
        board.tiles[x][y] = tile;
        board.tiles[3][0] = blockingTile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 2);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should move to the left until blocked by another tile with a different value', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(-1, 0);

        int x = 3;
        int y = 0;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(4, x: 0, y: 0);

        // Starting board
        // |4|0|0|2|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // Ending board
        // |4|2|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // put the tiles in the board
        board.tiles[x][y] = tile;
        board.tiles[0][0] = blockingTile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 1);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });
    });
    group('move with merge', () {
      test('should move to the left and merge with the blocking tile', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(-1, 0);

        int x = 3;
        int y = 0;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(2, x: 0, y: 0);

        // Starting board
        // |2|0|0|2|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // Ending board
        // |4|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // put the tiles in the board
        board.tiles[x][y] = tile;
        board.tiles[0][0] = blockingTile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 0);
        expect(actual.y, y);
        expect(actual.hasMerged, true);
      });
      test('should move to the right and merge with the blocking tile', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(1, 0);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(2, x: 3, y: 0);

        // Starting board
        // |2|0|0|2|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // Ending board
        // |0|0|0|4|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // put the tiles in the board
        board.tiles[x][y] = tile;
        board.tiles[3][0] = blockingTile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 3);
        expect(actual.y, y);
        expect(actual.hasMerged, true);
      });
      test('should move down and merge with the blocking tile', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(0, 1);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(2, x: 0, y: 3);

        // Starting board
        // |2|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |2|0|0|0|

        // Ending board
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |4|0|0|0|

        // put the tiles in the board
        board.tiles[x][y] = tile;
        board.tiles[0][3] = blockingTile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 3);
        expect(actual.hasMerged, true);
      });
      test('should move up and merge with the blocking tile', () {
        // ARRANGE
        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        var vector = Vector(0, -1);

        int x = 0;
        int y = 3;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(2, x: 0, y: 0);

        // Starting board
        // |2|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |2|0|0|0|

        // Ending board
        // |4|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // put the tiles in the board
        board.tiles[x][y] = tile;
        board.tiles[0][0] = blockingTile;

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 0);
        expect(actual.hasMerged, true);
      });
    });
  });
}
