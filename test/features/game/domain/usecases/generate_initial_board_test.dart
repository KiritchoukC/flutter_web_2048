import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/generate_initial_board.dart';

void main() {
  GenerateInitialBoard usecase;

  setUp(() {
    usecase = GenerateInitialBoard();
  });

  group('GenerateInitialBoard', () {
    test('should return a board with 16 tiles', () async {
      // ARRANGE

      // ACT
      var actual = await usecase(NoParams());
      // ASSERT
      actual.fold((_) {}, (board) {
        expect(board.tiles.length, 16);
      });
    });
    test("should return a board with 15 '0' tiles", () async {
      // ARRANGE

      // ACT
      var actual = await usecase(NoParams());
      // ASSERT
      actual.fold((_) {}, (board) {
        var tiles0 = board.tiles.where((tile) => tile.value == 0);
        expect(tiles0.length, 15);
      });
    });
    test("should return a board with 1 '2' tile", () async {
      // ARRANGE

      // ACT
      var actual = await usecase(NoParams());
      // ASSERT
      actual.fold((_) {}, (board) {
        var tiles0 = board.tiles.where((tile) => tile.value == 2);
        expect(tiles0.length, 1);
      });
    });
  });
}
