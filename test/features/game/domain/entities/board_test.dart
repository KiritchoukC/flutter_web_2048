import 'package:flutter_test/flutter_test.dart';
import 'package:piecemeal/piecemeal.dart' as pm;

import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/coordinate.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/entities/vector.dart';
import 'package:flutter_web_2048/core/extensions/either_extensions.dart';

void main() {
  group('getEmptyTiles', () {
    test("should have a length of 16 for a blank board", () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyCellsCoordinate();
      // ASSERT
      expect(actual.length, 16);
    });

    test("should return all coordinates for a blank board", () {
      // ARRANGE
      var expected = [
        Coordinate(0, 0),
        Coordinate(0, 1),
        Coordinate(0, 2),
        Coordinate(0, 3),
        Coordinate(1, 0),
        Coordinate(1, 1),
        Coordinate(1, 2),
        Coordinate(1, 3),
        Coordinate(2, 0),
        Coordinate(2, 1),
        Coordinate(2, 2),
        Coordinate(2, 3),
        Coordinate(3, 0),
        Coordinate(3, 1),
        Coordinate(3, 2),
        Coordinate(3, 3)
      ];

      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyCellsCoordinate().toList();
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
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      tiles.set(2, 3, Tile(2, x: 2, y: 3));
      tiles.set(3, 3, Tile(2, x: 3, y: 3));
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyCellsCoordinate();
      // ASSERT
      expect(actual.length, 14);
    });

    test("should have a length of 0 for a full board", () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyCellsCoordinate();
      // ASSERT
      expect(actual.length, 0);
    });

    test("should return 0 index for a full board", () {
      // ARRANGE
      var expected = List<Map<String, int>>();
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));
      var board = Board(tiles);
      // ACT
      var actual = board.getEmptyCellsCoordinate();
      // ASSERT
      expect(actual.toList(), expected);
    });
  });

  group('getTileDestination', () {
    group('no move', () {
      test('should return same position if tile does not move (left)', () {
        // ARRANGE
        var vector = Vector(-1, 0);

        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles.set(x, y, tile);

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

        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        int x = 3;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles.set(x, y, tile);

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

        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles.set(x, y, tile);

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

        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        int x = 0;
        int y = 3;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles.set(x, y, tile);

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
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        var vector = Vector(1, 0);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles.set(x, y, tile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 3);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should move all the way to the left', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        var vector = Vector(-1, 0);

        int x = 3;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles.set(x, y, tile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 0);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should move all the way down', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        var vector = Vector(0, 1);

        int x = 0;
        int y = 0;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles.set(x, y, tile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 3);
        expect(actual.hasMerged, false);
      });

      test('should move all the way up', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        var vector = Vector(0, -1);

        int x = 0;
        int y = 3;

        var tile = Tile(2, x: x, y: y);

        // put the tile in the board
        board.tiles.set(x, y, tile);

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
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
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
        board.tiles.set(x, y, tile);
        board.tiles.set(0, 0, blockingTile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 1);
        expect(actual.hasMerged, false);
      });

      test('should move down until blocked by another tile with a different value', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
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
        board.tiles.set(x, y, tile);
        board.tiles.set(0, 3, blockingTile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 2);
        expect(actual.hasMerged, false);
      });

      test('should move to the right until blocked by another tile with a different value', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
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
        board.tiles.set(x, y, tile);
        board.tiles.set(3, 0, blockingTile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 2);
        expect(actual.y, y);
        expect(actual.hasMerged, false);
      });

      test('should move to the left until blocked by another tile with a different value', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
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
        board.tiles.set(x, y, tile);
        board.tiles.set(0, 0, blockingTile);

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
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
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
        board.tiles.set(x, y, tile);
        board.tiles.set(0, 0, blockingTile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 0);
        expect(actual.y, y);
        expect(actual.hasMerged, true);
      });
      test('should move to the right and merge with the blocking tile', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
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
        board.tiles.set(x, y, tile);
        board.tiles.set(3, 0, blockingTile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, 3);
        expect(actual.y, y);
        expect(actual.hasMerged, true);
      });
      test('should move down and merge with the blocking tile', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
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
        board.tiles.set(x, y, tile);
        board.tiles.set(0, 3, blockingTile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 3);
        expect(actual.hasMerged, true);
      });
      test('should move up and merge with the blocking tile', () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
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
        board.tiles.set(x, y, tile);
        board.tiles.set(0, 0, blockingTile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        expect(actual.x, x);
        expect(actual.y, 0);
        expect(actual.hasMerged, true);
      });
      test(
          'should move up and merge with the blocking tile but not with the previously merged tile',
          () {
        // ARRANGE
        var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
        var board = Board(tiles);

        var vector = Vector(0, -1);

        int x = 0;
        int y = 3;

        var tile = Tile(2, x: x, y: y);
        var blockingTile = Tile(2, x: 0, y: 1);
        var previouslyMergedTile = Tile(4, x: 0, y: 0, merged: true);

        // Starting board
        // |4|0|0|0|
        // |2|0|0|0|
        // |0|0|0|0|
        // |2|0|0|0|

        // Ending board
        // |4|0|0|0|
        // |4|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // put the tiles in the board
        board.tiles.set(x, y, tile);
        board.tiles.set(blockingTile.x, blockingTile.y, blockingTile);
        board.tiles.set(previouslyMergedTile.x, previouslyMergedTile.y, previouslyMergedTile);

        // ACT
        var actual = board.getTileDestination(tile, vector);
        // ASSERT
        // it should not have move to another column
        expect(actual.x, x);
        // it should have taken the blocking tile cell
        expect(actual.y, blockingTile.y);
        // it should have its [hasMerged] property to true
        expect(actual.hasMerged, true);
      });
    });
  });

  group('updateScore', () {
    test('without merge should 0', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      // ACT
      int actual = board.updateScore();
      // ASSERT
      expect(actual, 0);
    });

    test('with 1 merged tile should this tile value', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      var mergedTile = Tile(2, x: 0, y: 0, merged: true);
      board.tiles.set(mergedTile.x, mergedTile.y, mergedTile);

      // ACT
      int actual = board.updateScore();
      // ASSERT
      expect(actual, 2);
    });

    test('with multiple merged tiles should the sum of tiles value', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      board.tiles.set(0, 0, Tile(2, x: 0, y: 0, merged: true));
      board.tiles.set(0, 1, Tile(4, x: 0, y: 0, merged: true));
      board.tiles.set(0, 2, Tile(8, x: 0, y: 0, merged: true));
      board.tiles.set(0, 3, Tile(16, x: 0, y: 0, merged: true));
      board.tiles.set(1, 0, Tile(32, x: 0, y: 0, merged: true));

      int expected = 62;

      // ACT
      int actual = board.updateScore();
      // ASSERT
      expect(actual, expected);
    });
  });

  group('resetMergedTiles', () {
    test('should set all the merged tiles to false', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      board.tiles.set(0, 0, Tile(2, x: 0, y: 0, merged: true));
      board.tiles.set(0, 1, Tile(4, x: 0, y: 0, merged: true));
      board.tiles.set(0, 2, Tile(8, x: 0, y: 0, merged: true));
      board.tiles.set(0, 3, Tile(16, x: 0, y: 0, merged: true));
      board.tiles.set(1, 0, Tile(32, x: 0, y: 0, merged: true));

      // ACT
      board.resetMergedTiles();
      // ASSERT
      expect(board.mergedTiles.length, 0);
    });
  });

  group('resetNewTiles', () {
    test('should set all the new tiles to false', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      board.tiles.set(0, 0, Tile(2, x: 0, y: 0, isNew: true));
      board.tiles.set(0, 1, Tile(4, x: 0, y: 0, isNew: true));
      board.tiles.set(0, 2, Tile(8, x: 0, y: 0, isNew: true));
      board.tiles.set(0, 3, Tile(16, x: 0, y: 0, isNew: true));
      board.tiles.set(1, 0, Tile(32, x: 0, y: 0, isNew: true));

      // ACT
      board.resetNewTiles();
      // ASSERT
      expect(board.tiles.where((x) => x != null && x.isNew).length, 0);
    });
  });

  group('addRandomTile', () {
    test('should add a tile to the board', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      // ACT
      board.addRandomTile();
      // ASSERT
      expect(board.tiles.where((tile) => tile != null).length, 1);
    });
    test('should return [Right] for success', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      // ACT
      var actual = board.addRandomTile();
      // ASSERT
      expect(actual.isRight(), true);
    });
    test('should return [Left] for failure', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));
      var board = Board(tiles);

      // ACT
      var actual = board.addRandomTile();
      // ASSERT
      expect(actual.isLeft(), true);
    });
    test('should return tile with isNew property set to true', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      // ACT
      var actual = board.addRandomTile();

      // ASSERT
      expect(actual.getRight().isNew, true);
    });
  });

  group('getRandomEmptyTileCoordinate', () {
    test('should return an empty cell coordinate', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, () {});
      var board = Board(tiles);

      // ACT
      var actual = board.getRandomEmptyTileCoordinate();
      // ASSERT
      var coordinate = actual.getOrElse(() => null);
      var cell = board.tiles.get(coordinate.x, coordinate.y);
      expect(cell, null);
    });
    test('should return the empty cell coordinate', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));
      var board = Board(tiles);

      int emptyTileX = 2;
      int emptyTileY = 2;

      // remove a tile
      board.tiles.set(emptyTileX, emptyTileY, null);

      // ACT
      var actual = board.getRandomEmptyTileCoordinate();
      // ASSERT
      var coordinate = actual.getOrElse(() => null);
      expect(coordinate.x, emptyTileX);
      expect(coordinate.y, emptyTileY);
    });
    test('should return left if no empty cell', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));
      var board = Board(tiles);

      // ACT
      var actual = board.getRandomEmptyTileCoordinate();
      // ASSERT
      expect(actual.isLeft(), true);
    });
  });

  group('isBlocked', () {
    test('should return false if there is an empty cell', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));
      var board = Board(tiles);

      // set empty cell
      board.tiles.set(0, 0, null);

      // ACT
      bool actual = board.isBlocked();

      // ASSERT
      expect(actual, false);
    });

    test('should return false if there is an available merge', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));
      var board = Board(tiles);

      // ACT
      bool actual = board.isBlocked();

      // ASSERT
      expect(actual, false);
    });

    test('should return true if there is no empty cells and no merge available', () {
      // ARRANGE
      var tiles = pm.Array2D<Tile>.generated(4, 4, (x, y) => Tile(2, x: x, y: y));

      // put '4' tiles in between
      tiles.set(1, 0, Tile(4, x: 1, y: 0));
      tiles.set(3, 0, Tile(4, x: 3, y: 0));
      tiles.set(0, 1, Tile(4, x: 0, y: 1));
      tiles.set(2, 1, Tile(4, x: 2, y: 1));
      tiles.set(1, 2, Tile(4, x: 1, y: 2));
      tiles.set(3, 2, Tile(4, x: 3, y: 2));
      tiles.set(0, 3, Tile(4, x: 0, y: 3));
      tiles.set(2, 3, Tile(4, x: 2, y: 3));

      var board = Board(tiles);

      // |2|4|2|4|
      // |4|2|4|2|
      // |2|4|2|4|
      // |4|2|4|2|

      // ACT
      bool actual = board.isBlocked();

      // ASSERT
      expect(actual, true);
    });
  });

  group('clone', () {
    test('should return the same board with different reference', () {
      // ARRANGE
      var board = Board(pm.Array2D(4, 4));

      // ACT
      var actual = Board.clone(board);

      // ASSERT
      expect(actual == board, false);
    });
    test('should throw when board arg is null', () {
      // ARRANGE

      // ACT
      var call = () => Board.clone(null);
      // ASSERT
      expect(call, throwsArgumentError);
    });
  });
}
