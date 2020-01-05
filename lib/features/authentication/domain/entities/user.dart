enum AuthenticationProvider { Google, Facebook, Twitter, Anonymous }

class User {
  final String uid;
  final String username;
  final String email;
  final String picture;
  final AuthenticationProvider authenticationProvider;

  User(
    this.uid,
    this.username,
    this.email,
    this.picture,
    this.authenticationProvider,
  );
}
