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
  MockAuthenticationDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockAuthenticationDatasource();
    repository = AuthenticationRepositoryImpl(datasource: mockDatasource);
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
      when(mockDatasource.signInAnonymously()).thenThrow(FirebaseException());
      // ACT
      var actual = await repository.signInAnonymously();
      // ASSERT
      expect(actual, Left(FirebaseFailure()));
    });
    test('should return a [FirestoreFailure] when a [FirestoreException] is thrown by datasource',
        () async {
      // ARRANGE
      when(mockDatasource.signInAnonymously()).thenThrow(FirestoreException());
      // ACT
      var actual = await repository.signInAnonymously();
      // ASSERT
      expect(actual, Left(FirestoreFailure()));
    });

    test('should call datasource [signinAnonymously] method]', () async {
      // ACT
      await repository.signInAnonymously();
      // ASSERT
      verify(mockDatasource.signInAnonymously()).called(1);
    });

    test('should call datasource [updateUserData] method', () async {
      // ACT
      await repository.signInAnonymously();
      // ASSERT
      verify(mockDatasource.updateUserData(any)).called(1);
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

      when(mockDatasource.signInAnonymously()).thenAnswer((_) async => userModel);

      // ACT
      var user = await repository.signInAnonymously();

      // ASSERT
      expect(user, equals(Right(expectedUser)));
    });
  });

  group('signOut', () {
    test('should call datasource [signOut()] method', () async {
      // ACT
      await repository.signOut();

      // ASSERT
      verify(mockDatasource.signOut()).called(1);
    });

    test('should return [Right] on success', () async {
      // ACT
      var actual = await repository.signOut();
      // ASSERT
      expect(actual, equals(Right(null)));
    });

    test('should return [Left] with a [FirebaseFailure] on failure', () async {
      // ARRANGE
      when(mockDatasource.signOut()).thenThrow(FirebaseException());
      // ACT
      var actual = await repository.signOut();
      // ASSERT
      expect(actual, equals(Left(FirebaseFailure())));
    });

    test('should throw exception on unhandled exceptions', () async {
      // ARRANGE
      when(mockDatasource.signOut()).thenThrow(Exception());
      // ACT
      var call = () async => await repository.signOut();
      // ASSERT
      expect(call, throwsA(isA<Exception>()));
    });
  });
}
