import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/features/authentication/data/models/user_model.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseUser extends Mock implements FirebaseUser {}

void main() {
  test('should extend [User]', () async {
    // ARRANGE
    var userModel = UserModel(
      uid: 'uniqueId',
      username: 'username',
      email: 'email',
      picture: 'picture',
      authenticationProvider: AuthenticationProvider.Google,
    );
    // ASSERT
    expect(userModel, isA<User>());
  });

  group('fromFirebaseUser', () {
    test('should return [UserModel] filled with [FirebaseUser] properties', () async {
      // ARRANGE
      String username = 'username';
      String email = 'email@example.com';
      String picture = 'https://google/picture.jpg';
      var firebaseUser = MockFirebaseUser();
      when(firebaseUser.displayName).thenReturn(username);
      when(firebaseUser.email).thenReturn(email);
      when(firebaseUser.photoUrl).thenReturn(picture);

      // ACT
      var userModel = UserModel.fromFirebaseUser(
        firebaseUser: firebaseUser,
        authenticationProvider: AuthenticationProvider.Google,
      );

      // ASSERT
      expect(userModel.authenticationProvider, AuthenticationProvider.Google);
      expect(userModel.username, username);
      expect(userModel.email, email);
      expect(userModel.picture, picture);
    });
  });

  group('toJson', () {
    test('should convert the [UserModel] to json with the given [lastSeenDateTime]', () async {
      // ARRANGE
      var userModel = UserModel(
        uid: 'uid',
        username: 'username',
        email: 'email',
        picture: 'picture',
        authenticationProvider: AuthenticationProvider.Anonymous,
      );
      var lastSeenDateTime = DateTime.now();

      // ACT
      var actual = userModel.toJson(lastSeenDateTime: lastSeenDateTime);

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
