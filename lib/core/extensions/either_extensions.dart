import 'package:dartz/dartz.dart';

extension EitherExtensions<TLeft, TRight> on Either<TLeft, TRight> {
  TRight getRight() {
    if (this == null) {
      return null;
    }
    TRight result;
    fold((left) {}, (right) => result = right);
    return result;
  }
}
