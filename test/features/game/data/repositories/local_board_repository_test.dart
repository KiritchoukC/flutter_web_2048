import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/data/repositories/local_board_repository.dart';

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
      test("should add a '2' tile each update if move is possible", () async {
      });

      test("should return the same amount of '0' tiles if move is not possible", () async {
      });

      test(
          "should merge tiles when 2 '2' are on the same row and direction is left and should move set the merged tile on the left",
          () async {
      });

      test(
          "should merge tiles when 2 '2' are on the same row and direction is right and should move set the merged tile on the right",
          () async {
      });
    });
  });
}
