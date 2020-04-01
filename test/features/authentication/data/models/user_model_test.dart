import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/authentication/data/models/user_model.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseUser extends Mock implements FirebaseUser {}

void main() {
  test('should extend [User]', () async {
    // ARRANGE
    final userModel = UserModel(
      uid: 'uniqueId',
      username: 'username',
      email: 'email',
      picture: 'picture',
      authenticationProvider: AuthenticationProvider.google,
    );
    // ASSERT
    expect(userModel, isA<User>());
  });

  group('fromFirebaseUser', () {
    test('should return [UserModel] filled with [FirebaseUser] properties', () async {
      // ARRANGE
      const String username = 'username';
      const String email = 'email@example.com';
      const String picture = 'https://google/picture.jpg';
      final firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.photoUrl).thenReturn(picture);

      // ACT
      final userModel = UserModel.fromFirebaseUser(
        firebaseUser: firebaseUser,
        authenticationProvider: AuthenticationProvider.google,
      );

      // ASSERT
      expect(userModel.authenticationProvider, AuthenticationProvider.google);
      expect(userModel.username, username);
      expect(userModel.email, email);
      expect(userModel.picture, picture);
    });
  });

  group('toJson', () {
    test('should convert the [UserModel] to json with the given [lastSeenDateTime]', () async {
      // ARRANGE
      final userModel = UserModel(
        uid: 'uid',
        username: 'username',
        email: 'email',
        picture: 'picture',
        authenticationProvider: AuthenticationProvider.anonymous,
      );
      final lastSeenDateTime = DateTime.now();

      // ACT
      final actual = userModel.toJson(lastSeenDateTime: lastSeenDateTime);

      // ASSERT
      expect(
          actual,
          equals({
            'uid': userModel.uid,
            'email': userModel.email,
            'picture': userModel.picture,
            'username': userModel.username,
            'lastSeen': lastSeenDateTime
          }));
    });
  });
}
