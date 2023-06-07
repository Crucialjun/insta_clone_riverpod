import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_clon_rivrpo/state/auth/providers/auth_state_provider.dart';
import 'package:insta_clon_rivrpo/state/posts/typedefs/user_id.dart';

final userIdProvider = Provider<UserId?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.userId;
});
