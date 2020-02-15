import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  final List properties;
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

// General failures
class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class ApplicationFailure extends Failure {
  final String message;

  const ApplicationFailure({@required this.message});
}

class FirebaseFailure extends Failure {}

class FirestoreFailure extends Failure {}

class UserNotFoundFailure extends Failure {
  final String userId;
  final String password;

  const UserNotFoundFailure({@required this.userId, @required this.password});
}
