import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';

// The user model. Used to convert third parties entities to application entity.
class UserModel extends User {
  UserModel({
    @required String uid,
    @required String username,
    @required String email,
    @required String picture,
    @required AuthenticationProvider authenticationProvider,
  }) : super(uid, username, email, picture, authenticationProvider);

  /// Convert the [FirebaseUser] to [UserModel]
  factory UserModel.fromFirebaseUser({
    @required FirebaseUser firebaseUser,
    @required AuthenticationProvider authenticationProvider,
  }) {
    return UserModel(
      uid: firebaseUser.uid,
      username: firebaseUser.displayName,
      email: firebaseUser.email,
      picture: firebaseUser.photoUrl,
      authenticationProvider: authenticationProvider,
    );
  }

  /// Convert the [UserModel] to json
  Map<String, dynamic> toJson({DateTime lastSeenDateTime}) {
    return {
      'uid': this.uid,
      'email': this.email,
      'picture': this.picture,
      'username': this.username,
      'lastSeen': lastSeenDateTime ?? DateTime.now()
    };
  }
}
