import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';

void main() {
  group('SignIn', () {
    test('should extend AuthenticationEvent', () {
      // ARRANGE
      String _email = 'email@example.com';
      String _password = 'abc123';
      // ACT
      var signin = SignInEvent(_email, _password);
      // ASSERT
      expect(signin, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      String _email = 'email@example.com';
      String _password = 'abc123';
      var expected = <Object>[_email, _password];
      // ACT
      var signin = SignInEvent(_email, _password);
      // ASSERT
      expect(signin.props, expected);
    });
  });
  group('SignOut', () {
    test('should extend AuthenticationEvent', () {
      // ACT
      var anonymousSignIn = SignOutEvent();
      // ASSERT
      expect(anonymousSignIn, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var anonymousSignIn = SignOutEvent();
      // ASSERT
      expect(anonymousSignIn.props, expected);
    });
  });
  group('AnonymousSignIn', () {
    test('should extend AuthenticationEvent', () {
      // ACT
      var anonymousSignIn = AnonymousSignInEvent();
      // ASSERT
      expect(anonymousSignIn, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var anonymousSignIn = AnonymousSignInEvent();
      // ASSERT
      expect(anonymousSignIn.props, expected);
    });
  });
  group('GoogleSignIn', () {
    test('should extend AuthenticationEvent', () {
      // ACT
      var googleSignIn = GoogleSignInEvent();
      // ASSERT
      expect(googleSignIn, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      var expected = <Object>[];
      // ACT
      var googleSignIn = GoogleSignInEvent();
      // ASSERT
      expect(googleSignIn.props, expected);
    });
  });
}
