import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

/// Sign in Anonnymous usecase. Holds the logic for anonymous authentication
class SigninAnonymous extends UseCase<User, NoParams> {
  /// The authentication repository
  final AuthenticationRepository _repository;

  /// Initialize an instance of [SinginAnonymous]
  /// with [AuthenticationRepository] as a dependency
  SigninAnonymous(this._repository) : assert(_repository != null);

  /// Execute the usecase
  @override
  Future<Either<Failure, User>> call(NoParams params) {
    // simply return the repository result
    return _repository.signinAnonymously();
  }
}
