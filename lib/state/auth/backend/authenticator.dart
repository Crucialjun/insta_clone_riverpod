import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:insta_clon_rivrpo/state/auth/constants/constants.dart';
import 'package:insta_clon_rivrpo/state/auth/models/auth_results.dart';
import 'package:insta_clon_rivrpo/state/posts/typedefs/user_id.dart';

class Authenticator {
  FacebookAuth facebookAuth = FacebookAuth.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  UserId? get userId => currentUser?.uid;

  bool get isLoggedIn => userId != null;

  String get displayName => currentUser?.displayName ?? "";

  String? get email => currentUser?.email;

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    await facebookAuth.logOut();
  }

  Future<AuthResult> loginWithfacebook() async {
    final loginResult = await facebookAuth.login();

    final tokenResult = loginResult.accessToken?.token;

    if (tokenResult == null) {
      //user aborted
      return AuthResult.aborted;
    }

    final authCredentials = FacebookAuthProvider.credential(tokenResult);

    try {
      await firebaseAuth.signInWithCredential(authCredentials);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      if (e.code == Constants.accountExistsWithDifferentCredentials &&
          email != null &&
          credential != null) {
        final providers = await firebaseAuth.fetchSignInMethodsForEmail(email);

        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          currentUser?.linkWithCredential(credential);
        }

        return AuthResult.success;
      }

      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      Constants.emailScope,
    ]);

    final signInAccount = await googleSignIn.signIn();

    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;

    final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    try {
      await firebaseAuth.signInWithCredential(authCredential);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
