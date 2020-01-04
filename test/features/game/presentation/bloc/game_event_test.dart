import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/presentation/bloc/game_event.dart';

void main() {
  group('LoadInitialBoard', () {
    test('should extend GameEvent', () {
      // ACT
      var loadInitialBoard = LoadInitialBoardEvent();
      // ASSERT
      expect(loadInitialBoard, isA<GameEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var loadInitialBoard = LoadInitialBoardEvent();
      // ASSERT
      expect(loadInitialBoard.props, expected);
    });
  });
  group('Move', () {
    test('should extend GameEvent', () {
      // ARRANGE
      var direction = Direction.down;
      // ACT
      var move = MoveEvent(direction: direction);
      // ASSERT
      expect(move, isA<GameEvent>());
    });
    test('should have a props list with the direction', () {
      // ARRANGE
      var direction = Direction.down;
      var expected = <Object>[direction];
      // ACT
      var move = MoveEvent(direction: direction);
      // ASSERT
      expect(move.props, expected);
    });
  });
  group('NewGame', () {
    test('should extend GameEvent', () {
      // ACT
      var newGame = NewGameEvent();
      // ASSERT
      expect(newGame, isA<GameEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var newGame = NewGameEvent();
      // ASSERT
      expect(newGame.props, expected);
    });
  });
  group('LoadHighscore', () {
    test('should extend GameEvent', () {
      // ACT
      var event = LoadHighscoreEvent();
      // ASSERT
      expect(event, isA<GameEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var event = LoadHighscoreEvent();
      // ASSERT
      expect(event.props, expected);
    });
  });
  group('Undo', () {
    test('should extend GameEvent', () {
      // ACT
      var event = UndoEvent();
      // ASSERT
      expect(event, isA<GameEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var event = UndoEvent();
      // ASSERT
      expect(event.props, expected);
    });
  });
}
