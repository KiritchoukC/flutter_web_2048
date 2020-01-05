import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AnonymousSigninEvent extends AuthenticationEvent {}

class GoogleSigninEvent extends AuthenticationEvent {}

class FacebookSigninEvent extends AuthenticationEvent {}

class TwitterSigninEvent extends AuthenticationEvent {}

class SigninEvent extends AuthenticationEvent {
  final String _email;
  final String _password;

  SigninEvent(this._email, this._password);

  @override
  List<Object> get props => [_email, _password];
}
