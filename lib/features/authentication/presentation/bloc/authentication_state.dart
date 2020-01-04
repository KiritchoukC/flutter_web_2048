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
  final User _user;

  LoggedOutState(this._user);

  @override
  List<Object> get props => [_user];
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class LoggedInState extends AuthenticationState {
  final User _user;

  LoggedInState(this._user);

  @override
  List<Object> get props => [_user];
}

class AuthenticationErrorState extends AuthenticationState {
  final String _message;

  AuthenticationErrorState(this._message);

  @override
  List<Object> get props => [_message];
}
