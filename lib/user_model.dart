class User {
  final String email;
  final String username;

  User({required this.email, required this.username});

  // Metodo utile per creare una copia dell'utente con un nome diverso
  User copyWith({String? email, String? username}) {
    return User(
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }
}