import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  final List properties;
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [this.properties];
}

// General failures
class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class ApplicationFailure extends Failure{
  final String message;

  ApplicationFailure({@required this.message});
}
