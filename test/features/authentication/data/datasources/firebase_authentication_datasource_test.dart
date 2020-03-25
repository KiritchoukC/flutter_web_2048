import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/error/exceptions.dart';
import 'package:flutter_web_2048/features/authentication/data/datasources/authentication_datasource.dart';
import 'package:flutter_web_2048/features/authentication/data/datasources/firebase_authentication_datasource.dart';
import 'package:flutter_web_2048/features/authentication/data/models/user_model.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirestore extends Mock implements Firestore {}

class MockAuthResult extends Mock implements AuthResult {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}

void main() {
  FirebaseAuthenticationDatasource datasource;
  MockFirebaseAuth mockFirebaseAuth;
  MockFirestore mockFirestore;
  MockCollectionReference mockCollectionReference;
  MockDocumentReference mockDocumentReference;
  MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirestore = MockFirestore();
    mockGoogleSignIn = MockGoogleSignIn();
    datasource = FirebaseAuthenticationDatasource(
      firebaseAuth: mockFirebaseAuth,
      firestore: mockFirestore,
      googleSignIn: mockGoogleSignIn,
    );

    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
  });

  test('should implement [AuthenticationDatasource]', () {
    // ASSERT
    expect(datasource, isA<AuthenticationDatasource>());
  });

  test('should throw when initialized with null argument', () async {
    // ACT & ASSERT
    expect(
      () => FirebaseAuthenticationDatasource(
        firebaseAuth: null,
        firestore: null,
        googleSignIn: mockGoogleSignIn,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => FirebaseAuthenticationDatasource(
        firebaseAuth: null,
        firestore: mockFirestore,
        googleSignIn: null,
      ),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => FirebaseAuthenticationDatasource(
        firebaseAuth: mockFirebaseAuth,
        firestore: null,
        googleSignIn: null,
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  group('updateUserData', () {
    final testUser = UserModel(
      uid: 'uid',
      email: 'email',
      username: 'username',
      picture: 'picture',
      authenticationProvider: AuthenticationProvider.anonymous,
    );
    test('should return the [DocumentReference.setData()] method output', () async {
      // ARRANGE
      final setDataOutput = Future.value();

      when(mockDocumentReference.setData(
        testUser.toJson(lastSeenDateTime: DateTime.now()),
        merge: true,
      )).thenAnswer((_) => setDataOutput);
      when(mockCollectionReference.document(testUser.uid)).thenReturn(mockDocumentReference);
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);

      // ACT
      final actual = datasource.updateUserData(testUser);

      // ASSERT
      expect(actual, isA<Future>());
    });
    test('should call [DocumentReference.setData()]', () async {
      // ARRANGE
      final setDataOutput = Future.value();
      final lastSeendDateTime = DateTime.now();

      when(mockDocumentReference.setData(
        testUser.toJson(lastSeenDateTime: lastSeendDateTime),
        merge: true,
      )).thenAnswer((_) => setDataOutput);
      when(mockCollectionReference.document(testUser.uid)).thenReturn(mockDocumentReference);
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);

      // ACT
      await datasource.updateUserData(testUser);

      // ASSERT
      verify(mockDocumentReference.setData(
        testUser.toJson(lastSeenDateTime: lastSeendDateTime),
        merge: true,
      )).called(1);
    }, retry: 5);
    test('should call [CollectionReference.document()]', () async {
      // ARRANGE
      final setDataOutput = Future.value();
      final lastSeendDateTime = DateTime.now();

      when(mockDocumentReference.setData(
        testUser.toJson(lastSeenDateTime: lastSeendDateTime),
        merge: true,
      )).thenAnswer((_) => setDataOutput);
      when(mockCollectionReference.document(testUser.uid)).thenReturn(mockDocumentReference);
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);

      // ACT
      await datasource.updateUserData(testUser);

      // ASSERT
      verify(mockCollectionReference.document(testUser.uid)).called(1);
    });
    test('should call [Firestore.collection()]', () async {
      // ARRANGE
      final setDataOutput = Future.value();
      final lastSeendDateTime = DateTime.now();

      when(mockDocumentReference.setData(
        testUser.toJson(lastSeenDateTime: lastSeendDateTime),
        merge: true,
      )).thenAnswer((_) => setDataOutput);
      when(mockCollectionReference.document(testUser.uid)).thenReturn(mockDocumentReference);
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);

      // ACT
      await datasource.updateUserData(testUser);

      // ASSERT
      verify(mockFirestore.collection('users')).called(1);
    });

    test('should throw a FirestoreException if something goes wrong', () async {
      // ARRANGE
      when(mockDocumentReference.setData(any, merge: true)).thenThrow(Exception());
      when(mockCollectionReference.document(testUser.uid)).thenReturn(mockDocumentReference);
      when(mockFirestore.collection('users')).thenReturn(mockCollectionReference);

      // ACT
      Future call() async => datasource.updateUserData(testUser);

      // ASSERT
      expect(call, throwsA(isA<FirestoreException>()));
    });
  });

  group('signOut', () {
    test('should call [FirebaseAuth.signOut()]', () async {
      // ACT
      await datasource.signOut();
      // ASSERT
      verify(mockFirebaseAuth.signOut()).called(1);
    });

    test('should throw a [FirebaseException] when an error occurs', () async {
      // ARRANGE
      when(mockFirebaseAuth.signOut()).thenThrow(Exception());

      // ACT
      Future call() async => datasource.signOut();

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });
  });

  group('signInWithEmailAndPassword', () {
    test('should call [Firebase.signInWithEmailAndPassword()] function', () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';
      const String username = 'username';
      const String photoUrl = 'photoUrl';
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.photoUrl).thenReturn(photoUrl);

      final authResult = MockAuthResult();
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) async => authResult);

      // ACT
      await datasource.signInWithEmailAndPassword(email, password);

      // ASSERT
      verify(mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
          .called(1);
    });
    test(
        'should throw [FirebaseException] if [Firebase.signInWithEmailAndPassword()] function returns NULL',
        () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';

      when(mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) async => null);

      // ACT
      Future call() async => datasource.signInWithEmailAndPassword(email, password);

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });

    test('should returns a [UserModel]', () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';
      const String username = 'username';
      const String photoUrl = 'photoUrl';
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.photoUrl).thenReturn(photoUrl);

      final authResult = MockAuthResult();
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) async => authResult);

      // ACT
      final actual = await datasource.signInWithEmailAndPassword(email, password);

      // ASSERT
      expect(actual, isA<UserModel>());
    });

    test('should throw [FirebaseException] if [Firebase.signInWithEmailAndPassword()] fails',
        () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';

      when(mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
          .thenThrow(Exception());

      // ACT
      Future call() async => datasource.signInWithEmailAndPassword(email, password);

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });

    test(
        'should throw [UserNotFoundException] if [Firebase.signInWithEmailAndPassword()] throw PlatformException with the ERROR_USER_NOT_FOUND code',
        () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';

      when(mockFirebaseAuth.signInWithEmailAndPassword(email: email, password: password))
          .thenThrow(PlatformException(code: 'ERROR_USER_NOT_FOUND'));

      // ACT
      Future call() async => datasource.signInWithEmailAndPassword(email, password);

      // ASSERT
      expect(call, throwsA(isA<UserNotFoundException>()));
    });
  });

  group('signInWithGoogle', () {
    const accessToken = 'accessToken';
    const idToken = 'idToken';

    const email = 'email';
    const username = 'username';
    const picture = 'picture';
    const uid = 'uid';

    test('should call [GoogleSignIn.signIn()]', () async {
      // ARRANGE
      final googleSignInAuthentication = MockGoogleSignInAuthentication();
      when(googleSignInAuthentication.accessToken).thenReturn(accessToken);
      when(googleSignInAuthentication.idToken).thenReturn(idToken);

      final googleSignInAccount = MockGoogleSignInAccount();
      when(googleSignInAccount.authentication).thenAnswer((_) async => googleSignInAuthentication);
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);

      final authResult = MockAuthResult();
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.uid).thenReturn(uid);
      when(firebaseUser.photoUrl).thenReturn(picture);
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer((_) async => authResult);

      // ACT
      await datasource.signInWithGoogle();

      // ASSERT
      verify(mockGoogleSignIn.signIn()).called(1);
    });
    test('should call [GoogleSignInAccount.authentication]', () async {
      // ARRANGE
      final googleSignInAuthentication = MockGoogleSignInAuthentication();
      when(googleSignInAuthentication.accessToken).thenReturn(accessToken);
      when(googleSignInAuthentication.idToken).thenReturn(idToken);

      final googleSignInAccount = MockGoogleSignInAccount();
      when(googleSignInAccount.authentication).thenAnswer((_) async => googleSignInAuthentication);
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);

      final authResult = MockAuthResult();
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.uid).thenReturn(uid);
      when(firebaseUser.photoUrl).thenReturn(picture);
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer((_) async => authResult);

      // ACT
      await datasource.signInWithGoogle();

      // ASSERT
      verify(googleSignInAccount.authentication).called(1);
    });

    test('should call [FirebaseAuth.signInWithCredential()]', () async {
      // ARRANGE
      final googleSignInAuthentication = MockGoogleSignInAuthentication();
      when(googleSignInAuthentication.accessToken).thenReturn(accessToken);
      when(googleSignInAuthentication.idToken).thenReturn(idToken);

      final googleSignInAccount = MockGoogleSignInAccount();
      when(googleSignInAccount.authentication).thenAnswer((_) async => googleSignInAuthentication);
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);

      final authResult = MockAuthResult();
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.uid).thenReturn(uid);
      when(firebaseUser.photoUrl).thenReturn(picture);
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer((_) async => authResult);

      // ACT
      await datasource.signInWithGoogle();

      // ASSERT
      verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
    });

    test('should return authenticated user', () async {
      // ARRANGE
      final googleSignInAuthentication = MockGoogleSignInAuthentication();
      when(googleSignInAuthentication.accessToken).thenReturn(accessToken);
      when(googleSignInAuthentication.idToken).thenReturn(idToken);

      final googleSignInAccount = MockGoogleSignInAccount();
      when(googleSignInAccount.authentication).thenAnswer((_) async => googleSignInAuthentication);
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);

      final authResult = MockAuthResult();
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.uid).thenReturn(uid);
      when(firebaseUser.photoUrl).thenReturn(picture);
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer((_) async => authResult);

      // ACT
      final actual = await datasource.signInWithGoogle();

      // ASSERT
      expect(actual.authenticationProvider, AuthenticationProvider.google);
      expect(actual.email, email);
      expect(actual.username, username);
      expect(actual.picture, picture);
      expect(actual.uid, uid);
    });

    test('should throw [GoogleSignInFailedException] if [GoogleSignIn.signIn()] fails', () async {
      // ARRANGE
      when(mockGoogleSignIn.signIn()).thenThrow(Exception());

      // ACT
      Future<UserModel> call() async => datasource.signInWithGoogle();

      // ASSERT
      expect(call, throwsA(isA<GoogleSignInFailedException>()));
    });

    test('should throw [FirebaseException] if [FirebaseAuth.signInWithCredential()] fails',
        () async {
      // ARRANGE
      final googleSignInAuthentication = MockGoogleSignInAuthentication();
      when(googleSignInAuthentication.accessToken).thenReturn(accessToken);
      when(googleSignInAuthentication.idToken).thenReturn(idToken);

      final googleSignInAccount = MockGoogleSignInAccount();
      when(googleSignInAccount.authentication).thenAnswer((_) async => googleSignInAuthentication);
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);

      final authResult = MockAuthResult();
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.uid).thenReturn(uid);
      when(firebaseUser.photoUrl).thenReturn(picture);
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.signInWithCredential(any)).thenThrow(Exception());

      // ACT
      Future<UserModel> call() async => datasource.signInWithGoogle();

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });
  });

  group('signUpWithEmailAndPassword', () {
    test('should call [Firebase.createUserWithEmailAndPassword()] function', () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';
      const String username = 'username';
      const String photoUrl = 'photoUrl';
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.photoUrl).thenReturn(photoUrl);

      final authResult = MockAuthResult();
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) async => authResult);

      // ACT
      await datasource.signUpWithEmailAndPassword(email, password);

      // ASSERT
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .called(1);
    });
    test(
        'should throw [FirebaseException] if [Firebase.createUserWithEmailAndPassword()] function returns NULL',
        () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';

      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) async => null);

      // ACT
      Future call() async => datasource.signUpWithEmailAndPassword(email, password);

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });

    test('should returns a [UserModel]', () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';
      const String username = 'username';
      const String photoUrl = 'photoUrl';
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.photoUrl).thenReturn(photoUrl);

      final authResult = MockAuthResult();
      when(authResult.user).thenReturn(firebaseUser);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) async => authResult);

      // ACT
      final actual = await datasource.signUpWithEmailAndPassword(email, password);

      // ASSERT
      expect(actual, isA<UserModel>());
    });

    test('should throw [FirebaseException] if [Firebase.createUserWithEmailAndPassword()] fails',
        () async {
      // ARRANGE
      const String email = 'email@example.com';
      const String password = 'password';

      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenThrow(Exception());

      // ACT
      Future call() async => datasource.signUpWithEmailAndPassword(email, password);

      // ASSERT
      expect(call, throwsA(isA<FirebaseException>()));
    });
  });
}
