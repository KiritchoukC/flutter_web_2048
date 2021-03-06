import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/authentication/presentation/bloc/bloc.dart';

void main() {
  group('SignIn', () {
    test('should extend AuthenticationEvent', () {
      // ARRANGE
      const String _email = 'email@example.com';
      const String _password = 'abc123';
      // ACT
      const signin = SignInEvent(email: _email, password: _password);
      // ASSERT
      expect(signin, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      const String _email = 'email@example.com';
      const String _password = 'abc123';
      const expected = <Object>[_email, _password];
      // ACT
      const signin = SignInEvent(email: _email, password: _password);
      // ASSERT
      expect(signin.props, expected);
    });
  });
  group('SignUp', () {
    test('should extend AuthenticationEvent', () {
      // ARRANGE
      const String _email = 'email@example.com';
      const String _password = 'abc123';
      // ACT
      const signin = SignUpEvent(email: _email, password: _password);
      // ASSERT
      expect(signin, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      const String _email = 'email@example.com';
      const String _password = 'abc123';
      const expected = <Object>[_email, _password];
      // ACT
      const signin = SignUpEvent(email: _email, password: _password);
      // ASSERT
      expect(signin.props, expected);
    });
  });
  group('SignOut', () {
    test('should extend AuthenticationEvent', () {
      // ACT
      final anonymousSignIn = SignOutEvent();
      // ASSERT
      expect(anonymousSignIn, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      final expected = <Object>[];
      // ACT
      final anonymousSignIn = SignOutEvent();
      // ASSERT
      expect(anonymousSignIn.props, expected);
    });
  });
  group('SignUpCancel', () {
    test('should extend AuthenticationEvent', () {
      // ACT
      const anonymousSignIn = SignUpCancelEvent();
      // ASSERT
      expect(anonymousSignIn, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      const expected = <Object>[];
      // ACT
      const anonymousSignIn = SignUpCancelEvent();
      // ASSERT
      expect(anonymousSignIn.props, expected);
    });
  });
  group('GoogleSignIn', () {
    test('should extend AuthenticationEvent', () {
      // ACT
      const googleSignIn = GoogleSignInEvent();
      // ASSERT
      expect(googleSignIn, isA<AuthenticationEvent>());
    });
    test('should have an empty props list', () {
      // ARRANGE
      final expected = <Object>[];
      // ACT
      const googleSignIn = GoogleSignInEvent();
      // ASSERT
      expect(googleSignIn.props, expected);
    });
  });
}
