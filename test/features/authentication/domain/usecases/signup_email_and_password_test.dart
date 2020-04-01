import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:flutter_web_2048/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signup_email_and_password.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() {
  SignUpEmailAndPassword usecase;
  MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    usecase = SignUpEmailAndPassword(repository: mockRepository);
  });

  test('should implements [UseCase<User, SignUpEmailAndPasswordParams>]', () {
    // ASSERT
    expect(usecase, isA<UseCase<User, SignUpEmailAndPasswordParams>>());
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => SignUpEmailAndPassword(repository: null), throwsA(isA<AssertionError>()));
  });

  test('should call the repository', () async {
    // ARRANGE
    const String email = 'email@example.com';
    const String password = 'password';
    // ACT
    await usecase(const SignUpEmailAndPasswordParams(email: email, password: password));
    // ASSERT
    verify(mockRepository.signUpWithEmailAndPassword(email: email, password: password)).called(1);
  });

  test('should return [FirebaseFailure] on Left case', () async {
    // ARRANGE
    const String email = 'email@example.com';
    const String password = 'password';

    when(mockRepository.signUpWithEmailAndPassword(email: email, password: password))
        .thenAnswer((_) async => Left(FirebaseFailure()));

    // ACT
    final result =
        await usecase(const SignUpEmailAndPasswordParams(email: email, password: password));

    // ASSERT
    expect(result, Left(FirebaseFailure()));
  });

  test('should return [FirestoreFailure] on Left case', () async {
    // ARRANGE
    const String email = 'email@example.com';
    const String password = 'password';

    when(mockRepository.signUpWithEmailAndPassword(email: email, password: password))
        .thenAnswer((_) async => Left(FirestoreFailure()));

    // ACT
    final result =
        await usecase(const SignUpEmailAndPasswordParams(email: email, password: password));

    // ASSERT
    expect(result, Left(FirestoreFailure()));
  });

  test('should return [User] on Right case', () async {
    // ARRANGE
    const String email = 'email@example.com';
    const String password = 'password';

    final user =
        User('uniqueId', 'username', 'email', 'picture', AuthenticationProvider.emailAndPassword);
    when(mockRepository.signUpWithEmailAndPassword(email: email, password: password))
        .thenAnswer((_) async => Right(user));

    // ACT
    final result =
        await usecase(const SignUpEmailAndPasswordParams(email: email, password: password));

    // ASSERT
    expect(result, Right(user));
  });
}
