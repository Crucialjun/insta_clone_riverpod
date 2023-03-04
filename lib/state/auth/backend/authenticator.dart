import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_clon_rivrpo/state/posts/typedefs/user_id.dart';

class Authenticator {
  User? get currentUser => FirebaseAuth.instance.currentUser;
  UserId? get userId => currentUser?.uid;

  bool get isLoggedIn => userId != null;

  String get displayName => currentUser?.displayName ?? "";
}
