import '../models/user_model.dart';

/// Interface for third parties authentication providers
abstract class AuthenticationDatasource {
  /// Provide a user model to anonymous users.
  Future<UserModel> signInAnonymously();

  /// Updates or persists user's data
  Future<void> updateUserData(UserModel user);

  /// Signs the current user out
  Future<void> signOut();

  /// Signs user with [email] and [password]
  Future<UserModel> signInWithEmailAndPassword(String email, String password);

  /// Signs user with Google
  Future<UserModel> signInWithGoogle();

  /// Signs up user with [email] and [password]
  Future<UserModel> signUpWithEmailAndPassword(String email, String password);
}
