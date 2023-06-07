import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_clon_rivrpo/state/auth/backend/authenticator.dart';
import 'package:insta_clon_rivrpo/state/auth/models/auth_results.dart';
import 'package:insta_clon_rivrpo/state/auth/models/auth_state.dart';
import 'package:insta_clon_rivrpo/state/posts/typedefs/user_id.dart';
import 'package:insta_clon_rivrpo/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isLoggedIn) {
      state = AuthState(
          isLoading: false,
          result: AuthResult.success,
          userId: _authenticator.userId);
    }
  }

  Future logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logout();
    state = const AuthState.unknown();
  }

  Future loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(isLoading: false, result: result, userId: userId);
  }

  Future loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(isLoading: false, result: result, userId: userId);
  }

  Future saveUserInfo({required UserId userId}) async {
    await _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email ?? "");
  }
}
