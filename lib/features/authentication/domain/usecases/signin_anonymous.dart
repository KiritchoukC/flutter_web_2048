import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

/// Sign in Anonnymous usecase. Holds the logic for anonymous authentication
class SignInAnonymous extends UseCase<User, NoParams> {
  /// The authentication repository
  final AuthenticationRepository _repository;

  /// Initialize an instance of [SinginAnonymous]
  /// with [AuthenticationRepository] as a dependency
  SignInAnonymous({@required AuthenticationRepository repository})
      : _repository = repository,
        assert(repository != null);

  /// Execute the usecase
  @override
  Future<Either<Failure, User>> call(NoParams params) => _repository.signInAnonymously();
}
