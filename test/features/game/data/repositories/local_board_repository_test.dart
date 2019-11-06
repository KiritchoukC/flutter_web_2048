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
        expect(actual.tiles.length, 16);
      });
      test("should return a board with 14 '0' tiles", () async {
        // ARRANGE

        // ACT
        var actual = await repository.getCurrentBoard();
        // ASSERT
        var tiles0 = actual.tiles.where((tile) => tile.value == 0);
        expect(tiles0.length, 14);
      });
      test("should return a board with 2 '2' tile", () async {
        // ARRANGE

        // ACT
        var actual = await repository.getCurrentBoard();
        // ASSERT
        var tiles0 = actual.tiles.where((tile) => tile.value == 2);
        expect(tiles0.length, 2);
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
      test("should add a '2' tile each update if move is possible", () async {
        // ARRANGE
        var direction = Direction.up;

        // Generate the first 14 tiles.
        var tiles = List<Tile>.generate(14, (index) {
          return Tile(0);
        });
        // Simulate a generated board by adding 2 tiles at the end
        tiles.add(Tile(2));
        tiles.add(Tile(2));

        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|2|2|
        var board = Board(tiles);

        // ACT
        // Update the board by moving up
        var actual = await repository.updateBoard(board, direction);

        // ASSERT
        var tiles2 = actual.tiles.where((tile) => tile.value == 2);
        expect(tiles2.length, 3);
      });

      test("should return the same amount of '0' tiles if move is not possible",
          () async {
        // ARRANGE
        // impossible move since the tile are already at the bottom
        var direction = Direction.down;

        // Generate the first 14 tiles.
        var tiles = List<Tile>.generate(14, (index) {
          return Tile(0);
        });
        // Simulate a generated board by adding 2 tiles at the end
        tiles.add(Tile(2));
        tiles.add(Tile(2));

        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|2|2|
        var board = Board(tiles);

        // ACT
        // Update the board by moving up
        var actual = await repository.updateBoard(board, direction);

        // ASSERT
        expect(actual.tiles.where((tile) => tile.value == 0).length, 14);
      });

      test("should merge tiles when 2 '2' are on the same row and direction is left and should move set the merged tile on the left",
          () async {
        // ARRANGE
        // impossible move since the tile are already at the bottom
        var direction = Direction.left;

        // Generate the first 14 tiles.
        var tiles = List<Tile>.generate(14, (index) {
          return Tile(0);
        });
        // Simulate a generated board by adding 2 tiles at the end
        tiles.add(Tile(2));
        tiles.add(Tile(2));

        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|2|2|
        var board = Board(tiles);

        // ACT
        // Update the board by moving up
        var actual = await repository.updateBoard(board, direction);

        // ASSERT
        // 0 tiles should still be 14 because a new tile will be generated
        expect(actual.tiles.where((tile) => tile.value == 0).length, 14);
        // merged tile
        var mergedTile = actual.tiles.firstWhere((tile) => tile.value == 4);
        // should be at the end of the board
        expect(actual.tiles.indexOf(mergedTile), 15);
        // new generated tile
        expect(actual.tiles.where((tile) => tile.value == 2).length, 1);
      });

      test("should merge tiles when 2 '2' are on the same row and direction is right and should move set the merged tile on the right",
          () async {
        // ARRANGE
        // impossible move since the tile are already at the bottom
        var direction = Direction.right;

        // Generate the first 14 tiles.
        var tiles = List<Tile>.generate(14, (index) {
          return Tile(0);
        });
        // Simulate a generated board by adding 2 tiles at the end
        tiles.add(Tile(2));
        tiles.add(Tile(2));

        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|0|0|
        // |0|0|2|2|
        var board = Board(tiles);

        // ACT
        // Update the board by moving up
        var actual = await repository.updateBoard(board, direction);

        // ASSERT
        // 0 tile should still be 14 because a new tile will be generated
        expect(actual.tiles.where((tile) => tile.value == 0).length, 14);
        // merged tile
        var mergedTile = actual.tiles.firstWhere((tile) => tile.value == 4);
        // should be at the start of the last row of the board
        expect(actual.tiles.indexOf(mergedTile), 11);
        // new generated tile
        expect(actual.tiles.where((tile) => tile.value == 2).length, 1);
      });
    });
  });
}
