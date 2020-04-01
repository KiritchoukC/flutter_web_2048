import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class InitialAuthenticationState extends AuthenticationState {}

class SignedOutState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class SignedInState extends AuthenticationState {
  final User user;

  const SignedInState({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;

  const AuthenticationErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

class UserNotFoundState extends AuthenticationState {
  final String email;
  final String password;

  String get name => email.split('@')[0];

  const UserNotFoundState({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
