import 'package:meta/meta.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class FirebaseException implements Exception {}

class FirestoreException implements Exception {}

class GoogleSignInFailedException implements Exception {}

class UserNotFoundException implements Exception {
  final String userId;

  const UserNotFoundException({@required this.userId});
}
