import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/messages.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/signin_anonymous.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SigninAnonymous _signinAnonymous;

  AuthenticationBloc({@required SigninAnonymous signinAnonymous})
      : _signinAnonymous = signinAnonymous,
        assert(_signinAnonymous != null);

  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AnonymousSigninEvent) {
      yield* _handleAnonymousSigninEvent(event);
    }
  }

  Stream<AuthenticationState> _handleAnonymousSigninEvent(AnonymousSigninEvent event) async* {
    // yield loading state
    yield AuthenticationLoadingState();

    // call the usecase
    final output = await _signinAnonymous(NoParams());

    // what to do if something wrong happens
    var onFailure = (failure) async* {
      if (failure is FirebaseFailure) {
        yield AuthenticationErrorState(FirebaseErrorMessage);
      }
    };

    // what to do if everything went right
    var onSuccess = (user) async* {
      yield LoggedInState(user);
    };

    // fold the usecase result
    yield* output.fold(onFailure, onSuccess);
  }
}
