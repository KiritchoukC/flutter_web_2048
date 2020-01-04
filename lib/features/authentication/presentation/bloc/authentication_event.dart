import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AnonymousSignin extends AuthenticationEvent {}

class GoogleSignin extends AuthenticationEvent {}

class FacebookSignin extends AuthenticationEvent {}

class TwitterSignin extends AuthenticationEvent {}

class Signin extends AuthenticationEvent {
  final String _email;
  final String _password;

  Signin(this._email, this._password);

  @override
  List<Object> get props => [_email, _password];
}
