import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/signin_anonymous.dart';
import '../../domain/usecases/signout.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// the [SignInAnonymous] usecase.
  final SignInAnonymous _signInAnonymous;

  /// the [SignOut] usecase.
  final SignOut _signout;

  AuthenticationBloc({@required SignInAnonymous signInAnonymous, @required SignOut signout})
      : _signInAnonymous = signInAnonymous,
        _signout = signout,
        assert(
          signInAnonymous != null && signout != null,
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
  }

  /// Handle [AnonymousSignInEvent] event and yield the right state
  Stream<AuthenticationState> _handleAnonymousSignInEvent(AnonymousSignInEvent event) async* {
    yield AuthenticationLoadingState();

    var onFailure = (failure) async* {
      yield AuthenticationErrorState(ErrorMessages.firebase);
    };

    var onSuccess = (user) async* {
      yield SignedInState(user);
    };

    yield* (await _signInAnonymous(NoParams())).fold(onFailure, onSuccess);
  }

  /// Handle [SignOutEvent] event and yield the right state
  Stream<AuthenticationState> _handleSignOutEvent(SignOutEvent event) async* {
    yield AuthenticationLoadingState();

    var onFailure = (failure) async* {
      yield AuthenticationErrorState(ErrorMessages.firebase);
    };

    var onSuccess = (success) async* {
      yield SignedOutState();
    };

    yield* (await _signout(NoParams())).fold(onFailure, onSuccess);
  }
}
