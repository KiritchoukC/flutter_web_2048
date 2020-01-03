import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_2048/features/authentication/domain/entities/user.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'authentication_datasource.dart';

/// Using Firebase as the datasource for authentication.
class FirebaseAuthenticationDatasource implements AuthenticationDatasource {
  /// the firebase authentication instance
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationDatasource(this._firebaseAuth) : assert(_firebaseAuth != null);

  /// Sign in a user anonymously
  @override
  Future<UserModel> signinAnonymously() async {
    try {
      // Sign in anonymously to firebase
      var result = await _firebaseAuth.signInAnonymously();

      // If no result is returned from firebase then throw exception
      if (result == null) {
        throw FirebaseException();
      }

      // Return the firebase user
      return UserModel.fromFirebaseUser(result.user, AuthenticationProvider.Anonymous);
    } catch (e) {
      // Log error and throw exception
      print(e.toString());
      throw FirebaseException();
    }
  }
}
