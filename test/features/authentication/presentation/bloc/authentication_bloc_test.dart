import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/core/error/error_messages.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signin_email_and_password.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signin_google.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signout.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signup_email_and_password.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

class MockSignOut extends Mock implements SignOut {}

class MockSignInEmailAndPassword extends Mock implements SignInEmailAndPassword {}

class MockSignUpEmailAndPassword extends Mock implements SignUpEmailAndPassword {}

class MockSignInGoogle extends Mock implements SignInGoogle {}

void main() {
  AuthenticationBloc bloc;
  MockSignOut mockSignOut;
  MockSignInEmailAndPassword mockSignInEmailAndPassword;
  MockSignUpEmailAndPassword mockSignUpEmailAndPassword;
  MockSignInGoogle mockSignInGoogle;

  final User testUser = User(
    'uniqueid',
    'UsernameTest',
    'email@example.com',
    'https://google.com/picture.jpg',
    AuthenticationProvider.anonymous,
  );

  setUp(() {
    mockSignOut = MockSignOut();
    mockSignInEmailAndPassword = MockSignInEmailAndPassword();
    mockSignUpEmailAndPassword = MockSignUpEmailAndPassword();
    mockSignInGoogle = MockSignInGoogle();

    bloc = AuthenticationBloc(
      signout: mockSignOut,
      signInEmailAndPassword: mockSignInEmailAndPassword,
      signUpEmailAndPassword: mockSignUpEmailAndPassword,
      signInGoogle: mockSignInGoogle,
    );
  });

  tearDown(() {
    bloc?.close();
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(
      () => AuthenticationBloc(
        signout: null,
        signInEmailAndPassword: mockSignInEmailAndPassword,
        signUpEmailAndPassword: mockSignUpEmailAndPassword,
        signInGoogle: mockSignInGoogle,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => AuthenticationBloc(
        signout: mockSignOut,
        signInEmailAndPassword: null,
        signUpEmailAndPassword: mockSignUpEmailAndPassword,
        signInGoogle: mockSignInGoogle,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => AuthenticationBloc(
        signout: mockSignOut,
        signInEmailAndPassword: mockSignInEmailAndPassword,
        signUpEmailAndPassword: null,
        signInGoogle: mockSignInGoogle,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => AuthenticationBloc(
        signout: mockSignOut,
        signInEmailAndPassword: mockSignInEmailAndPassword,
        signUpEmailAndPassword: mockSignUpEmailAndPassword,
        signInGoogle: null,
      ),
      throwsA(isA<AssertionError>()),
    );
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

  group('SignOutEvent', () {
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
        const AuthenticationErrorState(message: ErrorMessages.firebase),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(SignOutEvent());
    });
  });

  group('SignInEvent', () {
    test('should call [SignInEmailAndPassword] usecase', () async {
      // ARRANGE
      const email = 'e@mail.com';
      const password = 'abc123';
      const params = SignInEmailAndPasswordParams(email: email, password: password);
      when(mockSignInEmailAndPassword.call(params)).thenAnswer((_) async => Right(testUser));

      // ACT
      bloc.add(const SignInEvent(email: email, password: password));
      await untilCalled(mockSignInEmailAndPassword.call(params));

      // ASSERT
      verify(mockSignInEmailAndPassword.call(params));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, SignedInState] on success',
        () {
      // ARRANGE
      when(mockSignInEmailAndPassword.call(any)).thenAnswer((_) async => Right(testUser));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        SignedInState(user: testUser),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(const SignInEvent(email: 'email', password: 'password'));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, AuthenticationErrorState] on failure',
        () {
      // ARRANGE
      when(mockSignInEmailAndPassword.call(any)).thenAnswer((_) async => Left(FirebaseFailure()));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        const AuthenticationErrorState(message: ErrorMessages.firebase),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(const SignInEvent(email: 'email', password: 'password'));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, UserNotFoundState] on failure [UserNotFoundFailure]',
        () {
      // ARRANGE
      when(mockSignInEmailAndPassword.call(any)).thenAnswer(
          (_) async => Left(const UserNotFoundFailure(userId: 'email', password: 'abcd1234')));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        const UserNotFoundState(email: 'email', password: 'abcd1234'),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(const SignInEvent(email: 'email', password: 'password'));
    });
  });
  group('SignUpEvent', () {
    test('should call [SignUpEmailAndPassword] usecase', () async {
      // ARRANGE
      const email = 'e@mail.com';
      const password = 'abc123';
      const params = SignUpEmailAndPasswordParams(email: email, password: password);
      when(mockSignUpEmailAndPassword.call(params)).thenAnswer((_) async => Right(testUser));

      // ACT
      bloc.add(const SignUpEvent(email: email, password: password));
      await untilCalled(mockSignUpEmailAndPassword.call(params));

      // ASSERT
      verify(mockSignUpEmailAndPassword.call(params));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, SignedInState] on success',
        () {
      // ARRANGE
      when(mockSignUpEmailAndPassword.call(any)).thenAnswer((_) async => Right(testUser));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        SignedInState(user: testUser),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(const SignUpEvent(email: 'email', password: 'password'));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, AuthenticationErrorState] on failure',
        () {
      // ARRANGE
      when(mockSignUpEmailAndPassword.call(any)).thenAnswer((_) async => Left(FirebaseFailure()));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        const AuthenticationErrorState(message: ErrorMessages.firebase),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(const SignUpEvent(email: 'email', password: 'password'));
    });
  });

  group('SignUpCancelEvent', () {
    test('should emit [InitialAuthenticationState]', () async {
      // ARRANGE
      when(mockSignInEmailAndPassword.call(any)).thenAnswer(
          (_) async => Left(const UserNotFoundFailure(userId: 'email', password: 'abcd1234')));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(const SignUpCancelEvent());
    });
  });

  group('GoogleSignInEvent', () {
    test('should call [SignInGoogle] usecase', () async {
      // ARRANGE
      when(mockSignInGoogle.call(NoParams())).thenAnswer((_) async => Right(testUser));

      // ACT
      bloc.add(const GoogleSignInEvent());
      await untilCalled(mockSignInGoogle.call(NoParams()));

      // ASSERT
      verify(mockSignInGoogle.call(NoParams()));
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, SignedInState] on success',
        () {
      // ARRANGE
      when(mockSignInGoogle.call(any)).thenAnswer((_) async => Right(testUser));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        SignedInState(user: testUser),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(const GoogleSignInEvent());
    });

    test(
        'should emit [InitialAuthenticationState, AuthenticationLoadingState, AuthenticationErrorState] on failure',
        () {
      // ARRANGE
      when(mockSignInGoogle.call(any)).thenAnswer((_) async => Left(FirebaseFailure()));

      // ASSERT LATER
      final expected = [
        InitialAuthenticationState(),
        AuthenticationLoadingState(),
        const AuthenticationErrorState(message: ErrorMessages.firebase),
      ];

      expectLater(
        bloc,
        emitsInOrder(expected),
      );

      bloc.add(const GoogleSignInEvent());
    });
  });
}
