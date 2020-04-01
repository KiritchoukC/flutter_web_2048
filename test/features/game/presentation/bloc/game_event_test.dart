import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/presentation/bloc/game_event.dart';

void main() {
  group('LoadInitialBoard', () {
    test('should extend GameEvent', () {
      // ACT
      final loadInitialBoard = LoadInitialBoardEvent();
      // ASSERT
      expect(loadInitialBoard, isA<GameEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      final expected = <Object>[];
      // ACT
      final loadInitialBoard = LoadInitialBoardEvent();
      // ASSERT
      expect(loadInitialBoard.props, expected);
    });
  });
  group('Move', () {
    test('should extend GameEvent', () {
      // ARRANGE
      const direction = Direction.down;
      // ACT
      const move = MoveEvent(direction: direction);
      // ASSERT
      expect(move, isA<GameEvent>());
    });
    test('should have a props list with the direction', () {
      // ARRANGE
      const direction = Direction.down;
      const expected = <Object>[direction];
      // ACT
      const move = MoveEvent(direction: direction);
      // ASSERT
      expect(move.props, expected);
    });
  });
  group('NewGame', () {
    test('should extend GameEvent', () {
      // ACT
      final newGame = NewGameEvent();
      // ASSERT
      expect(newGame, isA<GameEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      final expected = <Object>[];
      // ACT
      final newGame = NewGameEvent();
      // ASSERT
      expect(newGame.props, expected);
    });
  });
  group('LoadHighscore', () {
    test('should extend GameEvent', () {
      // ACT
      final event = LoadHighscoreEvent();
      // ASSERT
      expect(event, isA<GameEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      final expected = <Object>[];
      // ACT
      final event = LoadHighscoreEvent();
      // ASSERT
      expect(event.props, expected);
    });
  });
  group('Undo', () {
    test('should extend GameEvent', () {
      // ACT
      final event = UndoEvent();
      // ASSERT
      expect(event, isA<GameEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      final expected = <Object>[];
      // ACT
      final event = UndoEvent();
      // ASSERT
      expect(event.props, expected);
    });
  });
}
