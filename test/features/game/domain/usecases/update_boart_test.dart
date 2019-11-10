import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/repositories/board_repository.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/update_board.dart';
import 'package:mockito/mockito.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

void main() {
  UpdateBoard usecase;
  MockBoardRepository repository;

  setUp(() {
    repository = MockBoardRepository();
    usecase = UpdateBoard(boardRepository: repository);
  });

  group('UpdateBoard', () {
    test('should use the repository', () async {
      // ARRANGE
      var tiles = List<List<Tile>>();
      var board = Board(tiles);
      var direction = Direction.right;

      when(repository.updateBoard(board, direction)).thenAnswer((_) async => Board(tiles));

      // ACT
      await usecase(Params(board: board, direction: direction));

      // ASSERT
      verify(repository.updateBoard(board, direction)).called(1);
    });

    test('should return the repository output', () async {
      // ARRANGE
      var tiles = List<List<Tile>>();
      var board = Board(tiles);
      var direction = Direction.right;

      var repositoryOutput = Board(List<List<Tile>>());

      when(repository.updateBoard(board, direction)).thenAnswer((_) async => repositoryOutput);

      // ACT
      var actual = await usecase(Params(board: board, direction: direction));

      // ASSERT
      expect(actual, repositoryOutput);
    });
  });
}
