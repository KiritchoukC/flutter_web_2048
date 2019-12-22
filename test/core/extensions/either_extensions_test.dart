import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/extensions/either_extensions.dart';

void main() {
  group('getRight', () {
    test('should return the right result', () {
      // ARRANGE
      var right = 'This is the right result';
      var either = Right(right);

      // ACT
      var actual = either.getRight();
      // ASSERT
      expect(right, actual);
    });
  });
}
