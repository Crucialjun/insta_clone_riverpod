import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_clon_rivrpo/firebase_options.dart';
import 'package:insta_clon_rivrpo/state/auth/backend/authenticator.dart';
import 'package:insta_clon_rivrpo/state/auth/models/auth_results.dart';
import 'package:insta_clon_rivrpo/state/auth/providers/auth_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          indicatorColor: Colors.blueGrey),
      home: Consumer(
        builder: (context, ref, child) {
          final isLoggedIn =
              ref.watch(authStateProvider).result == AuthResult.success;
          if (isLoggedIn) {
            return const LoginView();
          } else {
            return const MainView();
          }
        },
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
          onPressed: () {
            Authenticator().logout();
          },
          child: const Text("Log Out"),
        ),
        TextButton(
          onPressed: () async {
            final result = await Authenticator().loginWithGoogle();
            print(result.toString());
          },
          child: const Text("Sign In WIth google"),
        ),
        TextButton(
          onPressed: () async {
            final result = await Authenticator().loginWithFacebook();
            print(result.toString());
          },
          child: const Text("Sign In WIth Facebook"),
        ),
      ]),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Main View"),
        ),
        body: Center(child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return TextButton(
                onPressed: () async {
                  await ref.read(authStateProvider.notifier).logOut();
                },
                child: const Text("Log Out"));
          },
        )));
  }
}
