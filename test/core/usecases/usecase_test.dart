import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';

void main() {
  group('NoParams', () {
    test('should extend [Equatable]', () {
      // ACT
      final noparams = NoParams();
      // ASSERT
      expect(noparams, isA<Equatable>());
    });

    test('should have an empty props list', () {
      // ARRANGE
      final expected = <Object>[];

      // ACT
      final noparams = NoParams();

      // ASSERT
      expect(noparams.props, expected);
    });
  });
}
