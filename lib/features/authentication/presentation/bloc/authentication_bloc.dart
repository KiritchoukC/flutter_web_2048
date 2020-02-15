import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/signin_anonymous.dart';
import '../../domain/usecases/signin_email_and_password.dart';
import '../../domain/usecases/signout.dart';
import '../../domain/usecases/signup_email_and_password.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// the [SignInAnonymous] usecase.
  final SignInAnonymous _signInAnonymous;

  /// the [SignOut] usecase.
  final SignOut _signout;

  /// the [SignInEmailAndPassword] usecase.
  final SignInEmailAndPassword _signInEmailAndPassword;

  /// the [SignUpEmailAndPassword] usecase.
  final SignUpEmailAndPassword _signUpEmailAndPassword;

  AuthenticationBloc({
    @required SignInAnonymous signInAnonymous,
    @required SignOut signout,
    @required SignInEmailAndPassword signInEmailAndPassword,
    @required SignUpEmailAndPassword signUpEmailAndPassword,
  })  : _signInAnonymous = signInAnonymous,
        _signout = signout,
        _signInEmailAndPassword = signInEmailAndPassword,
        _signUpEmailAndPassword = signUpEmailAndPassword,
        assert(
          signInAnonymous != null &&
              signout != null &&
              signInEmailAndPassword != null &&
              signUpEmailAndPassword != null,
        );

  /// the Authentication Initial state
  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  /// Listens to event and yield the right state
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AnonymousSignInEvent) {
      yield* _handleAnonymousSignInEvent(event);
    }

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
  }

  /// Handle [AnonymousSignInEvent] event and yield the right state
  Stream<AuthenticationState> _handleAnonymousSignInEvent(AnonymousSignInEvent event) async* {
    yield AuthenticationLoadingState();

    Stream<AuthenticationState> onFailure(failure) async* {
      yield const AuthenticationErrorState(message: ErrorMessages.firebase);
    }

    Stream<AuthenticationState> onSuccess(User user) async* {
      yield SignedInState(user: user);
    }

    yield* (await _signInAnonymous(NoParams())).fold(onFailure, onSuccess);
  }

  /// Handle [SignOutEvent] event and yield the right state
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

  /// Handle [SignInEvent] event and yield the right state
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

  /// Handle [SignUpEvent] event and yield the right state
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

  /// Handle [SignUpCancelEvent] event and yield the right state
  Stream<AuthenticationState> _handleSignUpCancelEvent(SignUpCancelEvent event) async* {
    yield InitialAuthenticationState();
  }
}
