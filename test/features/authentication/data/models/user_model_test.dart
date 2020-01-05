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
      'uniqueId',
      'username',
      'email',
      'picture',
      AuthenticationProvider.Google,
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
      var userModel = UserModel.fromFirebaseUser(firebaseUser, AuthenticationProvider.Google);

      // ASSERT
      expect(userModel.authenticationProvider, AuthenticationProvider.Google);
      expect(userModel.username, username);
      expect(userModel.email, email);
      expect(userModel.picture, picture);
    });
  });
}
