import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class GoogleSignInEvent extends AuthenticationEvent {
  const GoogleSignInEvent();
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUpEvent({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOutEvent extends AuthenticationEvent {}

class SignUpCancelEvent extends AuthenticationEvent {
  const SignUpCancelEvent();
}
