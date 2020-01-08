import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class InitialAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class LoggedOutState extends AuthenticationState {
  final User user;

  LoggedOutState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class LoggedInState extends AuthenticationState {
  final User user;

  LoggedInState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;

  AuthenticationErrorState(this.message);

  @override
  List<Object> get props => [message];
}
