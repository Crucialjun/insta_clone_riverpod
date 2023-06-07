import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_clon_rivrpo/state/auth/models/auth_results.dart';
import 'package:insta_clon_rivrpo/state/auth/providers/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});
