import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/core/error/messages.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signin_anonymous.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

class MockSigninAnonymous extends Mock implements SigninAnonymous {}

void main() {
  AuthenticationBloc bloc;
  MockSigninAnonymous mockSigninAnonymous;
  User testUser = User(
    'uniqueid',
    'UsernameTest',
    'email@example.com',
    'https://google.com/picture.jpg',
    AuthenticationProvider.Anonymous,
  );

  setUp(() {
    mockSigninAnonymous = MockSigninAnonymous();

    bloc = AuthenticationBloc(
      signinAnonymous: mockSigninAnonymous,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => AuthenticationBloc(signinAnonymous: null), throwsA(isA<AssertionError>()));
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

  group('AnonymousSignin', () {
    test('should call [SigninAnonymous] usecase', () async {
      // ARRANGE
      when(mockSigninAnonymous.call(any)).thenAnswer((_) async => Right(testUser));

      // ACT
      bloc.add(AnonymousSigninEvent());
      await untilCalled(mockSigninAnonymous.call(any));

      // ASSERT
      verify(mockSigninAnonymous.call(any));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, LoggedInState] on success',
        () {
      // ARRANGE
      when(mockSigninAnonymous.call(any)).thenAnswer((_) async => Right(testUser));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        LoggedInState(testUser),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(AnonymousSigninEvent());
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, AuthenticationErrorState] on failure',
        () {
      // ARRANGE
      when(mockSigninAnonymous.call(any)).thenAnswer((_) async => Left(FirebaseFailure()));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        AuthenticationErrorState(FirebaseErrorMessage),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(AnonymousSigninEvent());
    });
  });
}
