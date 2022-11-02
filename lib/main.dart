import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialio/presentation/components/loading/loading_screen.dart';
import 'package:socialio/presentation/screens/auth_screen.dart';
import 'package:socialio/state/providers/is_loading_provider.dart';
import '/firebase_options.dart';
import 'dart:developer' as devtools show log;

import '/state/auth/infra/authenticator.dart';
import '/state/auth/providers/auth_state_provider.dart';
import '/state/auth/providers/is_logged_in_provider.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socialio',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        indicatorColor: Colors.blueGrey,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          ref.listen<bool>(isLoadingProvider, (_, isloading) {
            if (isloading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });
          final isLoggedId = ref.watch(isLoggedInProvider);
          if (isLoggedId) {
            return const HomeSrceen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

class HomeSrceen extends StatelessWidget {
  const HomeSrceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home screen'),
      ),
      body: Consumer(builder: (context, ref, child) {
        return Center(
          child: TextButton(
            onPressed: ref.read(authStateNotifierProvider.notifier).logOut,
            child: const Text('logOut'),
          ),
        );
      }),
    );
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TextButton(
          onPressed:
              ref.read(authStateNotifierProvider.notifier).loginWithFacebook,
          child: const Text('login with Facebook'),
        ),
        TextButton(
          onPressed:
              ref.read(authStateNotifierProvider.notifier).loginWithGoogle,
          child: const Text('login with Google'),
        ),
      ],
    );
  }
}
