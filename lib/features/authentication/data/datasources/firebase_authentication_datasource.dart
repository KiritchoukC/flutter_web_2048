import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_2048/core/util/helper_functions.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  /// the google sign in instance.
  final GoogleSignIn _googleSignIn;

  /// the logger instance
  final Logger _logger;

  static const _userNotFoundCode = 'ERROR_USER_NOT_FOUND';

  FirebaseAuthenticationDatasource({
    @required FirebaseAuth firebaseAuth,
    @required Firestore firestore,
    @required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _googleSignIn = googleSignIn,
        _logger = Logger('FirebaseAuthenticationDatasource'),
        assert(
          firebaseAuth != null && firestore != null && googleSignIn != null,
        );

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
      _logger.shout(e.toString());
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
      _logger.shout(e.toString());
      throw FirebaseException();
    }
  }

  /// Signs in a user with Email and password
  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    Future<AuthResult> signInUser() async {
      try {
        return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      } on PlatformException catch (e) {
        if (e.code == _userNotFoundCode) {
          throw UserNotFoundException(userId: email);
        } else {
          rethrow;
        }
      } catch (e) {
        // Log and throw specific exception
        _logger.shout(e.toString());
        throw FirebaseException();
      }
    }

    final authResult = await signInUser();

    if (authResult == null) {
      throw FirebaseException();
    }

    return UserModel.fromFirebaseUser(
      firebaseUser: authResult.user,
      authenticationProvider: AuthenticationProvider.emailAndPassword,
    );
  }

  /// Signs up a user with Email and password
  @override
  Future<UserModel> signUpWithEmailAndPassword(String email, String password) async {
    final authResult = await tryThrow(
      () => _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password),
      FirebaseException(),
    );

    if (authResult == null) {
      throw FirebaseException();
    }

    return UserModel.fromFirebaseUser(
      firebaseUser: authResult.user,
      authenticationProvider: AuthenticationProvider.emailAndPassword,
    );
  }

  /// Signs in a user with the Google provider
  @override
  Future<UserModel> signInWithGoogle() async {
    final googleSignInAccount = await tryThrow(_googleSignIn.signIn, GoogleSignInFailedException());

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final authResult = await tryThrow(
      () => _firebaseAuth.signInWithCredential(credential),
      FirebaseException(),
    );

    return UserModel.fromFirebaseUser(
      firebaseUser: authResult.user,
      authenticationProvider: AuthenticationProvider.google,
    );
  }
}
