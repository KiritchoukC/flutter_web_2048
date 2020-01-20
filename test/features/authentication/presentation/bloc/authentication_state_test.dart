import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';

void main() {
  final anonymousUser = User(
    'uniqueId',
    'username',
    'email@example.com',
    'https://google.com/picture.jpg',
    AuthenticationProvider.anonymous,
  );
  group('InitialAuthenticationState', () {
    test('should extend AuthenticationState', () {
      // ACT
      final initialState = InitialAuthenticationState();
      // ASSERT
      expect(initialState, isA<AuthenticationState>());
    });
    test('should have props list with the user', () {
      // ARRANGE
      final expected = <Object>[];
      // ACT
      final initialState = InitialAuthenticationState();
      // ASSERT
      expect(initialState.props, expected);
    });
  });
  group('SignedLoggedInState', () {
    test('should extend AuthenticationState', () {
      // ARRANGE
      final user = anonymousUser;
      // ACT
      final loggedIn = SignedInState(user);
      // ASSERT
      expect(loggedIn, isA<AuthenticationState>());
    });
    test('should have props list with the user', () {
      // ARRANGE
      final user = anonymousUser;
      final expected = <Object>[user];
      // ACT
      final loggedIn = SignedInState(user);
      // ASSERT
      expect(loggedIn.props, expected);
    });
  });
  group('SignedOutState', () {
    test('should extend AuthenticationState', () {
      // ACT
      final loggedOut = SignedOutState();
      // ASSERT
      expect(loggedOut, isA<AuthenticationState>());
    });
    test('should have props list with the user', () {
      // ARRANGE
      final expected = <Object>[];
      // ACT
      final loggedOut = SignedOutState();
      // ASSERT
      expect(loggedOut.props, expected);
    });
  });
  group('Error', () {
    test('should extend AuthenticationState', () {
      // ARRANGE
      const String message = 'message';
      // ACT
      const error = AuthenticationErrorState(message);
      // ASSERT
      expect(error, isA<AuthenticationState>());
    });
    test('should have a props list with the message', () {
      // ARRANGE
      const String message = 'message';
      const expected = <Object>[message];
      // ACT
      const error = AuthenticationErrorState(message);
      // ASSERT
      expect(error.props, expected);
    });
  });
}
