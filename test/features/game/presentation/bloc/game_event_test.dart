import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/presentation/bloc/game_event.dart';

void main() {
  group('LoadInitialBoard', (){
  test('should extend GameEvent', () {
    // ARRANGE
    // ACT
    GameEvent move = LoadInitialBoard();
    // ASSERT
    expect(move, isA<GameEvent>());
  });
    test('should have empty props list', (){
    // ARRANGE
    var expected = <Object>[];
    // ACT
    GameEvent move = LoadInitialBoard();
    // ASSERT
    expect(move.props, expected);
    });
  });
  group('Move', () {
    test('should extend GameEvent', () {
      // ARRANGE
      var direction = Direction.down;
      // ACT
      var move = Move(direction: direction);
      // ASSERT
      expect(move, isA<GameEvent>());
    });
    test('should have a props list with the direction', () {
      // ARRANGE
      var direction = Direction.down;
      var expected = <Object>[direction];
      // ACT
      var move = Move(direction: direction);
      // ASSERT
      expect(move.props, expected);
    });
  });
}
