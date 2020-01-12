import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

/// Sign in Anonnymous usecase. Holds the logic for anonymous authentication
class SignInEmailAndPassword extends UseCase<User, SignInEmailAndPasswordParams> {
  /// The authentication repository
  final AuthenticationRepository _repository;

  /// Initialize an instance of [SinginAnonymous]
  /// with [AuthenticationRepository] as a dependency
  SignInEmailAndPassword({@required AuthenticationRepository repository})
      : _repository = repository,
        assert(repository != null);

  /// Execute the usecase
  @override
  Future<Either<Failure, User>> call(SignInEmailAndPasswordParams params) =>
      _repository.signInWithEmailAndPassword(email: params.email, password: params.password);
}

class SignInEmailAndPasswordParams extends Equatable {
  final String email;
  final String password;

  SignInEmailAndPasswordParams({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
}
