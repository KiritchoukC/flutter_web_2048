import '../models/user_model.dart';

/// Interface for third parties authentication providers
abstract class AuthenticationDatasource {
  /// Updates or persists user's data
  Future<void> updateUserData(UserModel user, {DateTime lastSeenDateTime});

  /// Signs the current user out
  Future<void> signOut();

  /// Signs user with [email] and [password]
  Future<UserModel> signInWithEmailAndPassword(String email, String password);

  /// Signs user with Google
  Future<UserModel> signInWithGoogle();

  /// Signs up user with [email] and [password]
  Future<UserModel> signUpWithEmailAndPassword(String email, String password);
}
