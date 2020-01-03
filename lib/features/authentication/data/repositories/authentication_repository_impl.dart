import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_datasource.dart';

/// Implementation of the authentication repository
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  /// the authentication third party datasource
  final AuthenticationDatasource _datasource;

  AuthenticationRepositoryImpl(this._datasource) : assert(_datasource != null);

  /// Allow a user to sign in anonymously
  @override
  Future<Either<Failure, User>> signinAnonymously() async {
    try {
      // get user from datasource
      var user = await _datasource.signinAnonymously();

      // return the user
      return Right(user);
    } on FirebaseException {
      // on Firebase Exception, return a Firebase Failure
      return Left(FirebaseFailure());
    }
  }
}
