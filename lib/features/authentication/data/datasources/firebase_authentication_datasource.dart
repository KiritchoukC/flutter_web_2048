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

  /// Signs in a user anonymously
  @override
  Future<UserModel> signInAnonymously() async {
    try {
      var result = await _firebaseAuth.signInAnonymously();

      if (result == null) {
        throw FirebaseException();
      }

      return UserModel.fromFirebaseUser(
        firebaseUser: result.user,
        authenticationProvider: AuthenticationProvider.Anonymous,
      );
    } catch (e) {
      // Log and throw specific exception
      print(e.toString());
      throw FirebaseException();
    }
  }

  /// Updates or persists [user]'s data
  @override
  Future<void> updateUserData(UserModel user) async {
    try {
      return _firestore
          // Get the reference of the users collection
          .collection('users')
          // Get the reference of the users document
          .document(user.uid)
          // Update the user data with the user converted to json in the retrieved document reference
          // set [merge] to true so the the document will be updated instead of overwrited
          .setData(user.toJson(lastSeenDateTime: DateTime.now()), merge: true);
    } catch (e) {
      // Log and throw specific exception
      print(e.toString());
      throw FirestoreException();
    }
  }

  /// Signs out the current [user]
  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      // Log and throw specific exception
      print(e.toString());
      throw FirebaseException();
    }
  }

  /// Signs in a user with Email and password
  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    try {
      var authResult =
          await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (authResult == null) {
        throw FirebaseException();
      }

      return UserModel.fromFirebaseUser(
        firebaseUser: authResult.user,
        authenticationProvider: AuthenticationProvider.EmailAndPassword,
      );
    } catch (e) {
      throw FirebaseException();
    }
  }
}
