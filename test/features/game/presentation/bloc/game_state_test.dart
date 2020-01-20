import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

import 'package:flutter_web_2048/features/game/presentation/bloc/game_state.dart';
import 'package:piecemeal/piecemeal.dart';

void main() {
  group('GameOver', () {
    test('should extend GameState', () {
      // ARRANGE
      final board = Board(Array2D<Tile>(4, 4));
      // ACT
      final gameOver = GameOverState(board);
      // ASSERT
      expect(gameOver, isA<GameState>());
    });
    test('should have props list with the board', () {
      // ARRANGE
      final board = Board(Array2D<Tile>(4, 4));
      final expected = <Object>[board];
      // ACT
      final gameOver = GameOverState(board);
      // ASSERT
      expect(gameOver.props, expected);
    });
  });
  group('HighscoreLoaded', () {
    test('should extend GameState', () {
      // ARRANGE
      const int highscore = 9000;
      // ACT
      const state = HighscoreLoadedState(highscore);
      // ASSERT
      expect(state, isA<GameState>());
    });
    test('should have props list with the board and highscore', () {
      // ARRANGE
      const int highscore = 9000;
      const expected = <Object>[highscore];
      // ACT
      const state = HighscoreLoadedState(highscore);
      // ASSERT
      expect(state.props, expected);
    });
  });
  group('Error', () {
    test('should extend GameState', () {
      // ARRANGE
      const String message = 'message';
      // ACT
      const error = GameErrorState(message);
      // ASSERT
      expect(error, isA<GameState>());
    });
    test('should have a props list with the message', () {
      // ARRANGE
      const String message = 'message';
      const expected = <Object>[message];
      // ACT
      const error = GameErrorState(message);
      // ASSERT
      expect(error.props, expected);
    });
  });
}
