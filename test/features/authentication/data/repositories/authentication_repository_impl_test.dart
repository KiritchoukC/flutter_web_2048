import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/exceptions.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/features/authentication/data/datasources/authentication_datasource.dart';
import 'package:flutter_web_2048/features/authentication/data/models/user_model.dart';
import 'package:flutter_web_2048/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationDatasource extends Mock implements AuthenticationDatasource {}

void main() {
  AuthenticationRepositoryImpl repository;
  MockAuthenticationDatasource datasource;

  setUp(() {
    datasource = MockAuthenticationDatasource();
    repository = AuthenticationRepositoryImpl(datasource: datasource);
  });

  test('should implements [AuthenticationRepository]', () {
    // ASSERT
    expect(repository, isA<AuthenticationRepository>());
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => AuthenticationRepositoryImpl(datasource: null), throwsA(isA<AssertionError>()));
  });

  group('signinAnonymously', () {
    test('should return a [FirebaseFailure] when a [FirebaseException] is thrown by datasource',
        () async {
      // ARRANGE
      when(datasource.signinAnonymously()).thenThrow(FirebaseException());
      // ACT
      var actual = await repository.signinAnonymously();
      // ASSERT
      expect(actual, Left(FirebaseFailure()));
    });
    test('should return a [FirestoreFailure] when a [FirestoreException] is thrown by datasource',
        () async {
      // ARRANGE
      when(datasource.signinAnonymously()).thenThrow(FirestoreException());
      // ACT
      var actual = await repository.signinAnonymously();
      // ASSERT
      expect(actual, Left(FirestoreFailure()));
    });

    test('should call datasource [signinAnonymously] method]', () async {
      // ACT
      await repository.signinAnonymously();
      // ASSERT
      verify(datasource.signinAnonymously()).called(1);
    });

    test('should call datasource [updateUserData] method', () async {
      // ACT
      await repository.signinAnonymously();
      // ASSERT
      verify(datasource.updateUserData(any)).called(1);
    });

    test('should return a [User] for success requests', () async {
      // ARRANGE
      String uniqueId = 'uniqueId';
      String username = 'username';
      String email = 'email@example.com';
      String picture = 'https://google/picture.jpg';

      UserModel userModel = UserModel(
        uid: uniqueId,
        username: username,
        email: email,
        picture: picture,
        authenticationProvider: AuthenticationProvider.Anonymous,
      );

      User expectedUser = userModel;

      when(datasource.signinAnonymously()).thenAnswer((_) async => userModel);

      // ACT
      var user = await repository.signinAnonymously();

      // ASSERT
      expect(user, equals(Right(expectedUser)));
    });
  });
}
