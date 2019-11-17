import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/repositories/board_repository.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/reset_board.dart';
import 'package:mockito/mockito.dart';
import 'package:piecemeal/piecemeal.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

void main() {
  ResetBoard usecase;
  MockBoardRepository repository;

  setUp(() {
    repository = MockBoardRepository();
    usecase = ResetBoard(boardRepository: repository);
  });

  test('should call the repository', () async {
    // ACT
    await usecase(NoParams());

    // ASSERT
    verify(repository.resetBoard()).called(1);
    verify(repository.getCurrentBoard()).called(1);
  });
  test('should return the repository output', () async {
    // ARRANGE
    var repositoryOutput = Board(Array2D<Tile>(4, 4));
    when(repository.getCurrentBoard()).thenAnswer((_) async => repositoryOutput);

    // ACT
    var actual = await usecase(NoParams());

    // ASSERT
    expect(actual, repositoryOutput);
  });
  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => ResetBoard(boardRepository: null), throwsA(isA<AssertionError>()));
  });
}
