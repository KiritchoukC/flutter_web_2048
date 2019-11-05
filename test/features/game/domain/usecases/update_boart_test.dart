import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/repositories/board_repository.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/update_board.dart';
import 'package:mockito/mockito.dart';

class MockBoardRepository extends Mock implements BoardRepository{}

void main() {
  UpdateBoard usecase;
  MockBoardRepository repository;

  setUp(() {
    repository = MockBoardRepository();
    usecase = UpdateBoard(boardRepository: repository);
  });

  group('UpdateBoard', () {
    test('should generate a new tile every move', () async {
      // ARRANGE
      var tiles = <Tile>[];
      var board = Board(tiles);
      // ACT
      var actual = await usecase(Params(board: board, direction: Direction.right));
      // ASSERT
    });
  });
}
