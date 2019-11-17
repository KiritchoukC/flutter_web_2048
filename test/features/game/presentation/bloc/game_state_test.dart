import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

import 'package:flutter_web_2048/features/game/presentation/bloc/game_state.dart';
import 'package:piecemeal/piecemeal.dart';

void main() {
  group('GameOver', () {
    test('should extend GameState', () {
      // ARRANGE
      var board = Board(Array2D<Tile>(4, 4));
      // ACT
      var gameOver = GameOver(board);
      // ASSERT
      expect(gameOver, isA<GameState>());
    });
    test('should have props list with the board', () {
      // ARRANGE
      var board = Board(Array2D<Tile>(4, 4));
      var expected = <Object>[board];
      // ACT
      var gameOver = GameOver(board);
      // ASSERT
      expect(gameOver.props, expected);
    });
  });
  group('Error', () {
    test('should extend GameState', () {
      // ARRANGE
      String message = 'message';
      // ACT
      var error = Error(message);
      // ASSERT
      expect(error, isA<GameState>());
    });
    test('should have a props list with the message', () {
      // ARRANGE
      String message = 'message';
      var expected = <Object>[message];
      // ACT
      var error = Error(message);
      // ASSERT
      expect(error.props, expected);
    });
  });
}
