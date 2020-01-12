import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/authentication_repository.dart';

/// Signs out the current [User]
class SignOut extends UseCase<void, NoParams> {
  /// The authentication repository
  final AuthenticationRepository _repository;

  /// Initialize an instance of [SinginAnonymous]
  /// with [AuthenticationRepository] as a dependency
  SignOut({@required AuthenticationRepository repository})
      : _repository = repository,
        assert(repository != null);

  /// Execute the usecase
  @override
  Future<Either<Failure, void>> call(NoParams params) => _repository.signOut();
}
