import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart';

// The user model. Used to convert third parties entities to application entity.
class UserModel extends User {
  UserModel(
    String uid,
    String username,
    String email,
    String picture,
    AuthenticationProvider authenticationProvider,
  ) : super(uid, username, email, picture, authenticationProvider);

  factory UserModel.fromFirebaseUser(
    FirebaseUser firebaseUser,
    AuthenticationProvider authenticationProvider,
  ) {
    return UserModel(
      firebaseUser.uid,
      firebaseUser.displayName,
      firebaseUser.email,
      firebaseUser.photoUrl,
      authenticationProvider,
    );
  }
}
