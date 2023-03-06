import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_clon_rivrpo/state/auth/backend/authenticator.dart';
import 'package:insta_clon_rivrpo/state/auth/models/auth_results.dart';
import 'package:insta_clon_rivrpo/state/auth/models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = Authenticator();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isLoggedIn) {
      state = AuthState(
          isLoading: false,
          result: AuthResult.success,
          userId: _authenticator.userId);
    }
  }
}
