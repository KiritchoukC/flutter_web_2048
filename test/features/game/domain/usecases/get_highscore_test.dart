import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/game/domain/repositories/board_repository.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/get_highscore.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_web_2048/core/extensions/either_extensions.dart';

class MockBoardRepository extends Mock implements BoardRepository {}

void main() {
  GetHighscore usecase;
  MockBoardRepository repository;

  setUp(() {
    repository = MockBoardRepository();
    usecase = GetHighscore(boardRepository: repository);
  });

  test('should call the repository', () async {
    // ACT
    await usecase(NoParams());

    // ASSERT
    verify(repository.getHighscore()).called(1);
  });
  test('should return the repository output', () async {
    // ARRANGE
    const repositoryOutput = 70000;
    when(repository.getHighscore()).thenAnswer((_) async => repositoryOutput);

    // ACT
    final actual = await usecase(NoParams());

    // ASSERT
    expect(actual.getRight(), repositoryOutput);
  });
  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => GetHighscore(boardRepository: null), throwsA(isA<AssertionError>()));
  });
}
