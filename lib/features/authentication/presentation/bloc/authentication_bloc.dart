import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/signin_email_and_password.dart';
import '../../domain/usecases/signin_google.dart';
import '../../domain/usecases/signout.dart';
import '../../domain/usecases/signup_email_and_password.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// the [SignOut] usecase.
  final SignOut _signout;

  /// the [SignInEmailAndPassword] usecase.
  final SignInEmailAndPassword _signInEmailAndPassword;

  /// the [SignUpEmailAndPassword] usecase.
  final SignUpEmailAndPassword _signUpEmailAndPassword;

  /// the [SignInGoogle] usecase.
  final SignInGoogle _signInGoogle;

  AuthenticationBloc({
    @required SignOut signout,
    @required SignInEmailAndPassword signInEmailAndPassword,
    @required SignUpEmailAndPassword signUpEmailAndPassword,
    @required SignInGoogle signInGoogle,
  })  : _signout = signout,
        _signInEmailAndPassword = signInEmailAndPassword,
        _signUpEmailAndPassword = signUpEmailAndPassword,
        _signInGoogle = signInGoogle,
        assert(
          signout != null &&
              signInEmailAndPassword != null &&
              signUpEmailAndPassword != null &&
              signInGoogle != null,
        );

  /// the Authentication Initial state
  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  /// Listens to event and yield corresponding states
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is SignOutEvent) {
      yield* _handleSignOutEvent(event);
    }

    if (event is SignInEvent) {
      yield* _handleSignInEvent(event);
    }

    if (event is SignUpEvent) {
      yield* _handleSignUpEvent(event);
    }

    if (event is SignUpCancelEvent) {
      yield* _handleSignUpCancelEvent(event);
    }

    if (event is GoogleSignInEvent) {
      yield* _handleGoogleSignInEvent(event);
    }
  }

  /// Handle [SignOutEvent] event and yield corresponding states
  Stream<AuthenticationState> _handleSignOutEvent(SignOutEvent event) async* {
    yield AuthenticationLoadingState();

    Stream<AuthenticationState> onFailure(failure) async* {
      yield const AuthenticationErrorState(message: ErrorMessages.firebase);
    }

    Stream<AuthenticationState> onSuccess(success) async* {
      yield SignedOutState();
    }

    yield* (await _signout(NoParams())).fold(onFailure, onSuccess);
  }

  /// Handle [SignInEvent] event and yield corresponding states
  Stream<AuthenticationState> _handleSignInEvent(SignInEvent event) async* {
    yield AuthenticationLoadingState();

    Stream<AuthenticationState> onFailure(failure) async* {
      if (failure is UserNotFoundFailure) {
        yield UserNotFoundState(email: failure.userId, password: failure.password);
      } else {
        yield const AuthenticationErrorState(message: ErrorMessages.firebase);
      }
    }

    Stream<AuthenticationState> onSuccess(User user) async* {
      yield SignedInState(user: user);
    }

    yield* (await _signInEmailAndPassword(
            SignInEmailAndPasswordParams(email: event.email, password: event.password)))
        .fold(onFailure, onSuccess);
  }

  /// Handle [SignUpEvent] event and yield corresponding states
  Stream<AuthenticationState> _handleSignUpEvent(SignUpEvent event) async* {
    yield AuthenticationLoadingState();

    Stream<AuthenticationState> onFailure(failure) async* {
      yield const AuthenticationErrorState(message: ErrorMessages.firebase);
    }

    Stream<AuthenticationState> onSuccess(User user) async* {
      yield SignedInState(user: user);
    }

    yield* (await _signUpEmailAndPassword(
            SignUpEmailAndPasswordParams(email: event.email, password: event.password)))
        .fold(onFailure, onSuccess);
  }

  /// Handle [SignUpCancelEvent] event and yield corresponding states
  Stream<AuthenticationState> _handleSignUpCancelEvent(SignUpCancelEvent event) async* {
    yield InitialAuthenticationState();
  }

  /// Handle [GoogleSignInEvent] event and yield corresponding states
  Stream<AuthenticationState> _handleGoogleSignInEvent(GoogleSignInEvent event) async* {
    yield AuthenticationLoadingState();

    Stream<AuthenticationState> onFailure(failure) async* {
      yield const AuthenticationErrorState(message: ErrorMessages.firebase);
    }

    Stream<AuthenticationState> onSuccess(User user) async* {
      yield SignedInState(user: user);
    }

    yield* (await _signInGoogle(NoParams())).fold(onFailure, onSuccess);
  }
}
