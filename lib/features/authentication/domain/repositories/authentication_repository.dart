import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

/// Interface of the authentication repository
abstract class AuthenticationRepository {
  /// Allow a user to sign in anonymously
  Future<Either<Failure, User>> signInAnonymously();

  /// Signs out the current [User]
  Future<Either<Failure, void>> signOut();

  /// Signs in a [User] with [email] and [password]
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {@required String email, @required String password});
}
