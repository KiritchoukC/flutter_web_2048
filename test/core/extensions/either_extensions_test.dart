import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/extensions/either_extensions.dart';

void main() {
  group('getRight', () {
    test('should return the right result', () {
      // ARRANGE
      const right = 'This is the right result';
      final either = Right(right);

      // ACT
      final actual = either.getRight();
      // ASSERT
      expect(right, actual);
    });
  });
}
