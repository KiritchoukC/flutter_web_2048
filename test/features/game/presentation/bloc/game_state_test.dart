import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_web_2048/features/game/presentation/bloc/game_state.dart';

void main() {
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
