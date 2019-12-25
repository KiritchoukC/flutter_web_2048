import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';
import 'package:flutter_web_2048/features/game/domain/repositories/board_repository.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/get_previous_board.dart';
import 'package:mockito/mockito.dart';
import 'package:piecemeal/piecemeal.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

void main() {
  GetPreviousBoard usecase;
  MockBoardRepository repository;

  setUp(() {
    repository = MockBoardRepository();
    usecase = GetPreviousBoard(boardRepository: repository);
  });

  test('should call the repository', () async {
    // ACT
    await usecase(NoParams());

    // ASSERT
    verify(repository.getPreviousBoard()).called(1);
  });
  test('should return the repository output', () async {
    // ARRANGE
    var repositoryOutput = Board(Array2D<Tile>(4, 4));
    when(repository.getPreviousBoard()).thenAnswer((_) async => repositoryOutput);

    // ACT
    var actual = await usecase(NoParams());

    // ASSERT
    expect(actual, repositoryOutput);
  });
  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => GetPreviousBoard(boardRepository: null), throwsA(isA<AssertionError>()));
  });
}
