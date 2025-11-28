import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'user_model.dart';

part 'auth_provider.g.dart';

// Lo stato è un oggetto User nullable (User?).
// Se è null, vuol dire che siamo "Ospiti" (non loggati).
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  User? build() {
    return null; // Inizialmente non loggato
  }

  void login(String email) {
    // Simuliamo il login: l'username di default è l'email
    state = User(email: email, username: email);
  }

  void logout() {
    state = null;
  }

  void updateUsername(String newName) {
    // Se c'è un utente, aggiorniamo il suo nome
    if (state != null) {
      state = state!.copyWith(username: newName);
    }
  }
}