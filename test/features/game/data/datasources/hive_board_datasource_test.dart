import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/data/datasources/board_datasource.dart';
import 'package:flutter_web_2048/features/game/data/datasources/hive_board_datasource.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockLocalStorage with Mock implements Box<int> {}

void main() {
  HiveBoardDataSource datasource;
  MockLocalStorage mockLocalStorage;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    datasource = HiveBoardDataSource(localStorage: mockLocalStorage);
  });

  test('should implement [BoardDataSource]', () {
    // ASSERT
    expect(datasource, isA<BoardDataSource>());
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => HiveBoardDataSource(localStorage: null), throwsA(isA<AssertionError>()));
  });

  group('getHighscore', () {
    test('should return score in local storage', () async {
      // ARRANGE
      const int highscore = 700000;
      when(mockLocalStorage.get(highscoreKey)).thenReturn(highscore);

      // ACT
      final int actual = await datasource.getHighscore();

      // ASSERT
      expect(actual, highscore);
    });

    test('should return 0 and save it if no highscore yet', () async {
      // ARRANGE
      when(mockLocalStorage.get(highscoreKey)).thenReturn(null);

      // ACT
      final int actual = await datasource.getHighscore();

      // ASSERT
      verify(mockLocalStorage.put(highscoreKey, 0)).called(1);
      expect(actual, 0);
    });
  });

  group('saveHighscore', () {
    test('should call [localStorage] to save the score', () async {
      // ARRANGE
      const int highscore = 700000;
      when(mockLocalStorage.put(highscoreKey, highscore));

      // ACT
      await datasource.setHighscore(highscore);

      // ASSERT
      verify(mockLocalStorage.put(highscoreKey, highscore)).called(1);
    });
  });
}
