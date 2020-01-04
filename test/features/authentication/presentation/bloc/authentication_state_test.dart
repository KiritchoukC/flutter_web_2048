import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';

void main() {
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
  group('LoggedInState', () {
    test('should extend AuthenticationState', () {
      // ARRANGE
      var user = User('username', '', '', AuthenticationProvider.Anonymous);
      // ACT
      var loggedIn = LoggedInState(user);
      // ASSERT
      expect(loggedIn, isA<AuthenticationState>());
    });
    test('should have props list with the user', () {
      // ARRANGE
      var user = User('username', '', '', AuthenticationProvider.Anonymous);
      var expected = <Object>[user];
      // ACT
      var loggedIn = LoggedInState(user);
      // ASSERT
      expect(loggedIn.props, expected);
    });
  });
  group('LoggedOutState', () {
    test('should extend AuthenticationState', () {
      // ARRANGE
      var user = User('username', '', '', AuthenticationProvider.Anonymous);
      // ACT
      var loggedOut = LoggedOutState(user);
      // ASSERT
      expect(loggedOut, isA<AuthenticationState>());
    });
    test('should have props list with the user', () {
      // ARRANGE
      var user = User('username', '', '', AuthenticationProvider.Anonymous);
      var expected = <Object>[user];
      // ACT
      var loggedOut = LoggedOutState(user);
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
