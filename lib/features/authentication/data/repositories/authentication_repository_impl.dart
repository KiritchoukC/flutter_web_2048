import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_datasource.dart';

/// Implementation of the authentication repository
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  /// the authentication third party datasource
  final AuthenticationDatasource _datasource;

  AuthenticationRepositoryImpl({@required AuthenticationDatasource datasource})
      : _datasource = datasource,
        assert(datasource != null);

  /// Allow a user to sign in anonymously
  @override
  Future<Either<Failure, User>> signInAnonymously() async {
    try {
      final user = await _datasource.signInAnonymously();

      await _datasource.updateUserData(user);

      return Right(user);
    } on FirebaseException {
      return Left(FirebaseFailure());
    } on FirestoreException {
      return Left(FirestoreFailure());
    }
  }

  /// Signs out the current [User]
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return Right(await _datasource.signOut());
    } on FirebaseException {
      return Left(FirebaseFailure());
    }
  }

  /// Signs in a [User] with [email] and [password]
  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      final user = await _datasource.signInWithEmailAndPassword(email, password);

      await _datasource.updateUserData(user);

      return Right(user);
    } on FirebaseException {
      return Left(FirebaseFailure());
    } on FirestoreException {
      return Left(FirestoreFailure());
    }
  }
}
