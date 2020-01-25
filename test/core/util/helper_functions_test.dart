import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/exceptions.dart';
import 'package:flutter_web_2048/core/util/helper_functions.dart';

void main() {
  group('tryGet', () {
    test('should return given function result on success', () async {
      // ARRANGE
      String function() => 'result';

      // ACT
      final actual = tryGet(function, FirebaseException());

      // ASSERT
      expect(actual, 'result');
    });
    test('should throw given exception on error', () async {
      // ARRANGE
      String function() => throw Exception();

      // ACT
      String call() => tryGet(function, FirebaseException());

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });
  });
}
