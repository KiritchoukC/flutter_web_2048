import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/data/repositories/local_board_repository.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

void main() {
  LocalBoardRepository repository;

  setUp(() {
    repository = LocalBoardRepository();
  });

  group('LocalBoardRepository', () {
    group('getCurrentBoard', () {
      test('should return a board with 16 tiles', () async {
        // ARRANGE

        // ACT
        var actual = await repository.getCurrentBoard();
        // ASSERT
        expect(actual.flatTiles.length, 16);
      });
      test("should return a board with 14 empty tiles", () async {
        // ARRANGE

        // ACT
        var actual = await repository.getCurrentBoard();
        // ASSERT
        var emptyTiles = actual.flatTiles.where((tile) => tile == null);
        expect(emptyTiles.length, 14);
      });
      test("should return a board with 2 '2' tiles", () async {
        // ACT
        var actual = await repository.getCurrentBoard();
        // ASSERT
        var tiles2 = actual.flatTiles.where((tile) => tile?.value == 2);
        expect(tiles2.length, 2);
      });

      test('should return the same board on every call', () async {
        // ACT
        var firstActual = await repository.getCurrentBoard();
        var secondActual = await repository.getCurrentBoard();

        // ASSERT
        expect(firstActual, secondActual);
      });
    });

    group('resetBoard', () {
      test('should reset board. A new one should be generated after', () async {
        // ACT
        var boardBeforeReset = await repository.getCurrentBoard();
        await repository.resetBoard();
        var boardAfterReset = await repository.getCurrentBoard();

        // ASSERT
        expect(boardBeforeReset, isNot(equals(boardAfterReset)));
      });
    });

    group('updateBoard', () {
      test("should add a '2' or '4' tile each update if move is possible", () async {
        // ARRANGE
        var direction = Direction.down;

        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        int x = 1;
        int y = 0;

        // free tile should be able to move down
        var freeTile = Tile(2, x: x, y: y);
        board.tiles[x][y] = freeTile;

        // starting board
        // |0|2|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|

        // ACT
        var actual = await repository.updateBoard(board, direction);

        // ASSERT
        expect(
            actual.flatTiles
                .where((tile) => tile != null && (tile.value == 2 || tile.value == 4))
                .length,
            2);
      });

      test("should return the same amount of empty tiles if move is not possible", () async {
        // ARRANGE
        var direction = Direction.down;

        var tiles = List<List<Tile>>.generate(4, (y) => List(4));
        var board = Board(tiles);

        int x = 1;
        int y = 3;

        // blocked tile should not be able to move down
        var blockedTile = Tile(2, x: x, y: y);
        board.tiles[x][y] = blockedTile;

        // starting board
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|2|0|0|

        // ACT
        var actual = await repository.updateBoard(board, direction);

        // ASSERT
        expect(actual.flatTiles.where((tile) => tile == null).length, 15);
      });

      group('merge', () {
        test(
            "when 2 '2' are on the same row, direction is left and the merged tile move to the left",
            () async {
          // ARRANGE
          var direction = Direction.left;

          var tiles = List<List<Tile>>.generate(4, (y) => List(4));
          var board = Board(tiles);

          int leftX = 0;
          int rightX = 3;

          int y = 3;

          var leftTile = Tile(2, x: leftX, y: y);
          board.tiles[leftX][y] = leftTile;
          var rightTile = Tile(2, x: rightX, y: y);
          board.tiles[rightX][y] = rightTile;

          // starting board
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |2|0|0|2|

          // ending board
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |4|0|0|0|

          // ACT
          var actual = await repository.updateBoard(board, direction);

          // ASSERT
          var mergedTile = actual.tiles[leftX][y];
          expect(mergedTile.value, 4);
        });

        test(
            "when 2 '2' are on the same row, direction is right and the merged tile move to the right",
            () async {
          // ARRANGE
          var direction = Direction.right;

          var tiles = List<List<Tile>>.generate(4, (y) => List(4));
          var board = Board(tiles);

          int leftX = 0;
          int rightX = 3;

          int y = 3;

          var leftTile = Tile(2, x: leftX, y: y);
          board.tiles[leftX][y] = leftTile;
          var rightTile = Tile(2, x: rightX, y: y);
          board.tiles[rightX][y] = rightTile;

          // starting board
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |2|0|0|2|

          // ending board
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|4|

          // ACT
          var actual = await repository.updateBoard(board, direction);

          // ASSERT
          var mergedTile = actual.tiles[rightX][y];
          expect(mergedTile.value, 4);
        });

        test(
            "when 2 '2' are on the same column, direction is down and the merged tile move down",
            () async {
          // ARRANGE
          var direction = Direction.down;

          var tiles = List<List<Tile>>.generate(4, (y) => List(4));
          var board = Board(tiles);

          int topY = 0;
          int bottomY = 3;

          int x = 0;

          var topTile = Tile(2, x: x, y: topY);
          board.tiles[x][topY] = topTile;
          var downTile = Tile(2, x: x, y: bottomY);
          board.tiles[x][bottomY] = downTile;

          // starting board
          // |2|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |2|0|0|0|

          // ending board
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |4|0|0|0|

          // ACT
          var actual = await repository.updateBoard(board, direction);

          // ASSERT
          var mergedTile = actual.tiles[x][bottomY];
          expect(mergedTile.value, 4);
        });

        test(
            "when 2 '2' are on the same column, direction is up and should move the merged tile up",
            () async {
          // ARRANGE
          var direction = Direction.up;

          var tiles = List<List<Tile>>.generate(4, (y) => List(4));
          var board = Board(tiles);

          int topY = 0;
          int bottomY = 3;

          int x = 0;

          var topTile = Tile(2, x: x, y: topY);
          board.tiles[x][topY] = topTile;
          var downTile = Tile(2, x: x, y: bottomY);
          board.tiles[x][bottomY] = downTile;

          // starting board
          // |2|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |2|0|0|0|

          // ending board
          // |4|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|

          // ACT
          var actual = await repository.updateBoard(board, direction);

          // ASSERT
          var mergedTile = actual.tiles[x][topY];
          expect(mergedTile.value, 4);
        });
      });

      group('no merge', () {
        test("when 2 different tiles are on the same column, moving up", () async {
          // ARRANGE
          var direction = Direction.up;

          var tiles = List<List<Tile>>.generate(4, (y) => List(4));
          var board = Board(tiles);

          int topY = 0;
          int bottomY = 3;

          int x = 0;

          var topTile = Tile(4, x: x, y: topY);
          board.tiles[x][topY] = topTile;
          var downTile = Tile(2, x: x, y: bottomY);
          board.tiles[x][bottomY] = downTile;

          // starting board
          // |4|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |2|0|0|0|

          // ending board
          // |4|0|0|0|
          // |2|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|

          // ACT
          var actual = await repository.updateBoard(board, direction);

          // ASSERT
          var stillTile = actual.tiles[0][0];
          var movedTile = actual.tiles[0][1];
          expect(stillTile.value, 4);
          expect(movedTile.value, 2);
        });
        test("when 2 different tiles are on the same column, moving down", () async {
          // ARRANGE
          var direction = Direction.down;

          var tiles = List<List<Tile>>.generate(4, (y) => List(4));
          var board = Board(tiles);

          int topY = 0;
          int bottomY = 3;

          int x = 0;

          var topTile = Tile(4, x: x, y: topY);
          board.tiles[x][topY] = topTile;
          var downTile = Tile(2, x: x, y: bottomY);
          board.tiles[x][bottomY] = downTile;

          // starting board
          // |4|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |2|0|0|0|

          // ending board
          // |0|0|0|0|
          // |0|0|0|0|
          // |4|0|0|0|
          // |2|0|0|0|

          // ACT
          var actual = await repository.updateBoard(board, direction);

          // ASSERT
          var stillTile = actual.tiles[0][3];
          var movedTile = actual.tiles[0][2];
          expect(stillTile.value, 2);
          expect(movedTile.value, 4);
        });
        test("when 2 different tiles are on the same row, moving to the right", () async {
          // ARRANGE
          var direction = Direction.right;

          var tiles = List<List<Tile>>.generate(4, (y) => List(4));
          var board = Board(tiles);

          int leftX = 0;
          int rightX = 3;

          int y = 0;

          var leftTile = Tile(4, x: leftX, y: y);
          board.tiles[leftX][y] = leftTile;
          var rightTile = Tile(2, x: rightX, y: y);
          board.tiles[rightX][y] = rightTile;

          // starting board
          // |4|0|0|2|
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|

          // ending board
          // |0|0|4|2|
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|

          // ACT
          var actual = await repository.updateBoard(board, direction);

          // ASSERT
          var stillTile = actual.tiles[3][0];
          var movedTile = actual.tiles[2][0];
          expect(stillTile.value, 2);
          expect(movedTile.value, 4);
        });
        test("when 2 different tiles are on the same row, moving to the left", () async {
          // ARRANGE
          var direction = Direction.left;

          var tiles = List<List<Tile>>.generate(4, (y) => List(4));
          var board = Board(tiles);

          int leftX = 0;
          int rightX = 3;

          int y = 0;

          var leftTile = Tile(4, x: leftX, y: y);
          board.tiles[leftX][y] = leftTile;
          var rightTile = Tile(2, x: rightX, y: y);
          board.tiles[rightX][y] = rightTile;

          // starting board
          // |4|0|0|2|
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|

          // ending board
          // |4|2|0|0|
          // |0|0|0|0|
          // |0|0|0|0|
          // |0|0|0|0|

          // ACT
          var actual = await repository.updateBoard(board, direction);

          // ASSERT
          var stillTile = actual.tiles[0][0];
          var movedTile = actual.tiles[1][0];
          expect(stillTile.value, 4);
          expect(movedTile.value, 2);
        });
      });
    });
  });
}
