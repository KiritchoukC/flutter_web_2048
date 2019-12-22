import 'package:dartz/dartz.dart';

extension EitherExtensions<TLeft, TRight> on Either<TLeft, TRight> {
  TRight getRight() {
    TRight result;
    this.fold((left) {}, (right) => result = right);
    return result;
  }
}
