import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import 'authentication_datasource.dart';

/// Using Firebase as the datasource for authentication.
class FirebaseAuthenticationDatasource implements AuthenticationDatasource {
  /// the firebase authentication instance
  final FirebaseAuth _firebaseAuth;

  /// the firestore instance
  final Firestore _firestore;

  FirebaseAuthenticationDatasource({
    @required FirebaseAuth firebaseAuth,
    @required Firestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        assert(
          firebaseAuth != null && firestore != null,
        );

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

  // void _updateUserData(UserModel user) async {
  //   // Get the reference of the users docuement
  //   var ref = db.collection('users').document(user.uid);

  //   // Update the user data in the retrieved document reference
  //   return ref.setData({
  //     'uid': user.uid,
  //     'email': user.email,
  //     'photoURL': user.photoUrl,
  //     'displayName': user.displayName,
  //     'lastSeen': DateTime.now()
  //   }, merge: true);
  // }
}
