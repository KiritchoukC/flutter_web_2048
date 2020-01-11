import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AnonymousSignInEvent extends AuthenticationEvent {}

class GoogleSignInEvent extends AuthenticationEvent {}

class SignInEvent extends AuthenticationEvent {
  final String _email;
  final String _password;

  SignInEvent(this._email, this._password);

  @override
  List<Object> get props => [_email, _password];
}

class SignOutEvent extends AuthenticationEvent {}
