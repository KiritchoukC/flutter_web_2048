import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/data/repositories/local_board_repository.dart';

void main() {
  LocalBoardRepository repository;

  setUp(() {
    repository = LocalBoardRepository();
  });

  group('LocalBoardRepository', () {
    group('getInitialBoard', () {
      test('should return a board with 16 tiles', () async {
        // ARRANGE

        // ACT
        var actual = await repository.getInitialBoard();
        // ASSERT
        expect(actual.tiles.length, 16);
      });
      test("should return a board with 15 '0' tiles", () async {
        // ARRANGE

        // ACT
        var actual = await repository.getInitialBoard();
        // ASSERT
        var tiles0 = actual.tiles.where((tile) => tile.value == 0);
        expect(tiles0.length, 15);
      });
      test("should return a board with 1 '2' tile", () async {
        // ARRANGE

        // ACT
        var actual = await repository.getInitialBoard();
        // ASSERT
        var tiles0 = actual.tiles.where((tile) => tile.value == 2);
        expect(tiles0.length, 1);
      });
    });
  });
}
