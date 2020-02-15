import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

/// Sign in Anonnymous usecase. Holds the logic for anonymous authentication
class SignUpEmailAndPassword extends UseCase<User, SignUpEmailAndPasswordParams> {
  /// The authentication repository
  final AuthenticationRepository _repository;

  /// Initialize an instance of [SinginAnonymous]
  /// with [AuthenticationRepository] as a dependency
  SignUpEmailAndPassword({@required AuthenticationRepository repository})
      : _repository = repository,
        assert(repository != null);

  /// Execute the usecase
  @override
  Future<Either<Failure, User>> call(SignUpEmailAndPasswordParams params) =>
      _repository.signUpWithEmailAndPassword(email: params.email, password: params.password);
}

class SignUpEmailAndPasswordParams extends Equatable {
  final String email;
  final String password;

  const SignUpEmailAndPasswordParams({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
}
