import '../models/user_model.dart';

/// Interface for third parties authentication providers
abstract class AuthenticationDatasource {
  /// Provide a user model to anonymous users.
  Future<UserModel> signInAnonymously();

  /// update or persist user's data
  Future<void> updateUserData(UserModel user);

  /// signs the current user out
  Future<void> signOut();
}
