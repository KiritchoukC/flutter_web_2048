import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_web_2048/features/authentication/domain/usecases/signout.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

void main() {
  SignOut usecase;
  MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    usecase = SignOut(repository: mockRepository);
  });

  test('should implements [UseCase<void, NoParams>]', () {
    // ASSERT
    expect(usecase, isA<UseCase<void, NoParams>>());
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(() => SignOut(repository: null), throwsA(isA<AssertionError>()));
  });

  test('should call the repository', () async {
    // ACT
    await usecase(NoParams());
    // ASSERT
    verify(mockRepository.signOut()).called(1);
  });

  test('should return [FirebaseFailure] on Left case', () async {
    // ARRANGE
    when(mockRepository.signOut()).thenAnswer((_) async => Left(FirebaseFailure()));

    // ACT
    final result = await usecase(NoParams());

    // ASSERT
    expect(result, Left(FirebaseFailure()));
  });

  test('should return [null] on Right case', () async {
    // ARRANGE
    when(mockRepository.signOut()).thenAnswer((_) async => Right(null));

    // ACT
    final result = await usecase(NoParams());

    // ASSERT
    expect(result, Right(null));
  });
}
