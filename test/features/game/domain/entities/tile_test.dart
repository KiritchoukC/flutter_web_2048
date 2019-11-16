import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/game/domain/entities/destination.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

void main() {
  group('fromDestination', () {
    test('should return tile with x and y from destination', () {
      // ARRANGE
      int value = 2;
      var destination = Destination(
        x: 0,
        y: 0,
        hasMerged: false,
        hasMoved: false,
      );
      // ACT
      var tile = Tile.fromDestination(value, destination);
      // ASSERT
      expect(tile.x, destination.x);
      expect(tile.y, destination.y);
    });
    group('nomerge', () {
      test('should set [Tile.merged] to false', () {
        // ARRANGE
        int value = 2;
        var destination = Destination(
          x: 0,
          y: 0,
          hasMerged: false,
          hasMoved: false,
        );
        // ACT
        var tile = Tile.fromDestination(value, destination);
        // ASSERT
        expect(tile.merged, false);
      });
      test('should return the same value', () {
        // ARRANGE
        int value = 2;
        var destination = Destination(
          x: 0,
          y: 0,
          hasMerged: false,
          hasMoved: false,
        );
        // ACT
        var tile = Tile.fromDestination(value, destination);
        // ASSERT
        expect(tile.value, value);
      });
    });

    group('merge', () {
      test('should set [Tile.merged] to true', () {
        // ARRANGE
        int value = 2;
        var destination = Destination(
          x: 0,
          y: 0,
          hasMerged: true,
          hasMoved: true,
        );
        // ACT
        var tile = Tile.fromDestination(value, destination);
        // ASSERT
        expect(tile.merged, true);
      });
      test('should return doubled value', () {
        // ARRANGE
        int value = 2;
        var destination = Destination(
          x: 0,
          y: 0,
          hasMerged: true,
          hasMoved: true,
        );
        // ACT
        var tile = Tile.fromDestination(value, destination);
        // ASSERT
        expect(tile.value, value * 2);
      });
    });
  });
}
