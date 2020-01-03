import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/exceptions.dart';
import 'package:flutter_web_2048/features/authentication/data/datasources/authentication_datasource.dart';
import 'package:flutter_web_2048/features/authentication/data/datasources/firebase_authentication_datasource.dart';
import 'package:flutter_web_2048/features/authentication/data/models/user_model.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthResult extends Mock implements AuthResult {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

main() {
  FirebaseAuthenticationDatasource datasource;
  MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    datasource = FirebaseAuthenticationDatasource(mockFirebaseAuth);
  });

  test('should implement [AuthenticationDatasource]', () {
    // ASSERT
    expect(datasource, isA<AuthenticationDatasource>());
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => FirebaseAuthenticationDatasource(null), throwsA(isA<AssertionError>()));
  });

  group('SigninAnonymously', () {
    test('should call firebase auth', () async {
      // ARRANGE
      String username = 'username';
      String email = 'email';
      String photoUrl = 'photoUrl';
      var firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.photoUrl).thenReturn(photoUrl);

      var authResult = MockAuthResult();
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.signInAnonymously()).thenAnswer((_) async => authResult);

      // ACT
      await datasource.signinAnonymously();

      // ASSERT
      verify(mockFirebaseAuth.signInAnonymously()).called(1);
    });
    test('should throw a [FirebaseException] when datasource throw an error', () async {
      // ARRANGE
      when(mockFirebaseAuth.signInAnonymously()).thenThrow(Error);
      // ACT
      var call = () async => await datasource.signinAnonymously();

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });
    test('should throw a [FirebaseException] when datasource return null [AuthResult]', () async {
      // ARRANGE
      when(mockFirebaseAuth.signInAnonymously()).thenAnswer((_) => null);
      // ACT
      var call = () async => await datasource.signinAnonymously();

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });
    test('should return a [UserModel]', () async {
      // ARRANGE
      var authResult = MockAuthResult();
      when(authResult.user).thenReturn(MockFirebaseUser());
      when(mockFirebaseAuth.signInAnonymously()).thenAnswer((_) async => authResult);

      // ACT
      var user = await datasource.signinAnonymously();

      // ASSERT
      expect(user, isA<UserModel>());
    });
  });
}
