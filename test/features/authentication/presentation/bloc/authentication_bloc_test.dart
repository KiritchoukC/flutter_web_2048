import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/core/error/error_messages.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signin_anonymous.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signout.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

class MockSignInAnonymous extends Mock implements SignInAnonymous {}

class MockSignOut extends Mock implements SignOut {}

void main() {
  AuthenticationBloc bloc;
  MockSignInAnonymous mockSignInAnonymous;
  MockSignOut mockSignOut;

  User testUser = User(
    'uniqueid',
    'UsernameTest',
    'email@example.com',
    'https://google.com/picture.jpg',
    AuthenticationProvider.Anonymous,
  );

  setUp(() {
    mockSignInAnonymous = MockSignInAnonymous();
    mockSignOut = MockSignOut();

    bloc = AuthenticationBloc(
      signInAnonymous: mockSignInAnonymous,
      signout: mockSignOut,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => AuthenticationBloc(signInAnonymous: null, signout: mockSignOut),
        throwsA(isA<AssertionError>()));
    expect(() => AuthenticationBloc(signInAnonymous: mockSignInAnonymous, signout: null),
        throwsA(isA<AssertionError>()));
  });

  test('Initial state should be [InitialAuthenticationState]', () {
    // ASSERT
    expect(bloc.initialState, equals(InitialAuthenticationState()));
  });

  test('close should not emit new states', () {
    // ASSERT Later
    expectLater(
      bloc,
      emitsInOrder([InitialAuthenticationState(), emitsDone]),
    );

    // ACT
    bloc.close();
  });

  group('AnonymousSignIn', () {
    test('should call [SignInAnonymous] usecase', () async {
      // ARRANGE
      when(mockSignInAnonymous.call(any)).thenAnswer((_) async => Right(testUser));

      // ACT
      bloc.add(AnonymousSignInEvent());
      await untilCalled(mockSignInAnonymous.call(any));

      // ASSERT
      verify(mockSignInAnonymous.call(any));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, LoggedInState] on success',
        () {
      // ARRANGE
      when(mockSignInAnonymous.call(any)).thenAnswer((_) async => Right(testUser));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        SignedInState(testUser),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(AnonymousSignInEvent());
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, AuthenticationErrorState] on failure',
        () {
      // ARRANGE
      when(mockSignInAnonymous.call(any)).thenAnswer((_) async => Left(FirebaseFailure()));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        AuthenticationErrorState(ErrorMessages.firebase),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(AnonymousSignInEvent());
    });
  });

  group('SignOut', () {
    test('should call [SignOut] usecase', () async {
      // ARRANGE
      when(mockSignOut.call(any)).thenAnswer((_) async => Right(null));

      // ACT
      bloc.add(SignOutEvent());
      await untilCalled(mockSignOut.call(any));

      // ASSERT
      verify(mockSignOut.call(any));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, SignedOutState] on success',
        () async {
      // ARRANGE
      when(mockSignOut.call(any)).thenAnswer((_) async => Right(null));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        SignedOutState(),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(SignOutEvent());
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, SignedOutState] on failure',
        () async {
      // ARRANGE
      when(mockSignOut.call(any)).thenAnswer((_) async => Left(FirebaseFailure()));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        AuthenticationErrorState(ErrorMessages.firebase),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(SignOutEvent());
    });
  });
}
