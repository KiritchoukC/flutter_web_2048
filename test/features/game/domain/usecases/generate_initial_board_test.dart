import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/repositories/board_repository.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/generate_initial_board.dart';
import 'package:mockito/mockito.dart';

class MockBoardRepository extends Mock implements BoardRepository{}

void main() {
  GenerateInitialBoard usecase;
  MockBoardRepository repository;

  setUp(() {
    repository = MockBoardRepository();
    usecase = GenerateInitialBoard(boardRepository: repository);
  });

  group('GenerateInitialBoard', () {
    test('should call the repository', () async {
      // ACT
      await usecase(NoParams());
      
      // ASSERT
      verify(repository.getInitialBoard()).called(1);
    });
    test('should return the repository output', () async {
      // ARRANGE
      var repositoryOutput = Board(List<Tile>());
      when(repository.getInitialBoard()).thenAnswer((_) async => repositoryOutput);

      // ACT
      var actual = await usecase(NoParams());

      // ASSERT
      expect(actual, repositoryOutput);
    });
  });
}
