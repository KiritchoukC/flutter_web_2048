import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';

void main() {
  final anonymousUser = User(
    'uniqueId',
    'username',
    'email@example.com',
    'https://google.com/picture.jpg',
    AuthenticationProvider.Anonymous,
  );
  group('InitialAuthenticationState', () {
    test('should extend AuthenticationState', () {
      // ACT
      var initialState = InitialAuthenticationState();
      // ASSERT
      expect(initialState, isA<AuthenticationState>());
    });
    test('should have props list with the user', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var initialState = InitialAuthenticationState();
      // ASSERT
      expect(initialState.props, expected);
    });
  });
  group('SignedLoggedInState', () {
    test('should extend AuthenticationState', () {
      // ARRANGE
      var user = anonymousUser;
      // ACT
      var loggedIn = SignedInState(user);
      // ASSERT
      expect(loggedIn, isA<AuthenticationState>());
    });
    test('should have props list with the user', () {
      // ARRANGE
      var user = anonymousUser;
      var expected = <Object>[user];
      // ACT
      var loggedIn = SignedInState(user);
      // ASSERT
      expect(loggedIn.props, expected);
    });
  });
  group('SignedOutState', () {
    test('should extend AuthenticationState', () {
      // ACT
      var loggedOut = SignedOutState();
      // ASSERT
      expect(loggedOut, isA<AuthenticationState>());
    });
    test('should have props list with the user', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var loggedOut = SignedOutState();
      // ASSERT
      expect(loggedOut.props, expected);
    });
  });
  group('Error', () {
    test('should extend AuthenticationState', () {
      // ARRANGE
      String message = 'message';
      // ACT
      var error = AuthenticationErrorState(message);
      // ASSERT
      expect(error, isA<AuthenticationState>());
    });
    test('should have a props list with the message', () {
      // ARRANGE
      String message = 'message';
      var expected = <Object>[message];
      // ACT
      var error = AuthenticationErrorState(message);
      // ASSERT
      expect(error.props, expected);
    });
  });
}
