import 'package:equatable/equatable.dart';

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

  SignedInState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;

  AuthenticationErrorState(this.message);

  @override
  List<Object> get props => [message];
}
