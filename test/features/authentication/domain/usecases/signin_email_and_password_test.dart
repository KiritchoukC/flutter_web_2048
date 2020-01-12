import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signin_email_and_password.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() {
  SignInEmailAndPassword usecase;
  MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    usecase = SignInEmailAndPassword(repository: mockRepository);
  });

  test('should implements [UseCase<User, SignInEmailAndPasswordParams>]', () {
    // ASSERT
    expect(usecase, isA<UseCase<User, SignInEmailAndPasswordParams>>());
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => SignInEmailAndPassword(repository: null), throwsA(isA<AssertionError>()));
  });

  test('should call the repository', () async {
    // ARRANGE
    String email = 'email@example.com';
    String password = 'password';
    // ACT
    await usecase(SignInEmailAndPasswordParams(email: email, password: password));
    // ASSERT
    verify(mockRepository.signInWithEmailAndPassword(email: email, password: password)).called(1);
  });

  test('should return [FirebaseFailure] on Left case', () async {
    // ARRANGE
    String email = 'email@example.com';
    String password = 'password';

    when(mockRepository.signInWithEmailAndPassword(email: email, password: password))
        .thenAnswer((_) async => Left(FirebaseFailure()));

    // ACT
    var result = await usecase(SignInEmailAndPasswordParams(email: email, password: password));

    // ASSERT
    expect(result, Left(FirebaseFailure()));
  });

  test('should return [FirestoreFailure] on Left case', () async {
    // ARRANGE
    String email = 'email@example.com';
    String password = 'password';

    when(mockRepository.signInWithEmailAndPassword(email: email, password: password))
        .thenAnswer((_) async => Left(FirestoreFailure()));

    // ACT
    var result = await usecase(SignInEmailAndPasswordParams(email: email, password: password));

    // ASSERT
    expect(result, Left(FirestoreFailure()));
  });

  test('should return [User] on Right case', () async {
    // ARRANGE
    String email = 'email@example.com';
    String password = 'password';

    var user =
        User('uniqueId', 'username', 'email', 'picture', AuthenticationProvider.EmailAndPassword);
    when(mockRepository.signInWithEmailAndPassword(email: email, password: password))
        .thenAnswer((_) async => Right(user));

    // ACT
    var result = await usecase(SignInEmailAndPasswordParams(email: email, password: password));

    // ASSERT
    expect(result, Right(user));
  });
}
