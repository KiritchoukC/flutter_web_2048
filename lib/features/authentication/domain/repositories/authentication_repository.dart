import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

/// Interface of the authentication repository
abstract class AuthenticationRepository {
  /// Allow a user to sign in anonymously
  Future<Either<Failure, User>> signInAnonymously();

  /// Signs out the current [User]
  Future<Either<Failure, void>> signOut();
}
