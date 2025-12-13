import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'user_model.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  User? build() {
    return null;
  }

  void login(String email) {
    state = User(email: email, username: email);
  }

  void logout() {
    state = null;
  }

  void updateUsername(String newName) {
    if (state != null) {
      state = state!.copyWith(username: newName);
    }
  }
}