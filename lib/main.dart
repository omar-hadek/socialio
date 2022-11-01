import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialio/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:socialio/state/auth/infra/authenticator.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
        home: const HomeSrceen());
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
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              final result = await Authenticator().loginWithFacebook();
              result.log();
            },
            child: const Text('login with Facebook'),
          ),
          TextButton(
            onPressed: () async {
              final result = await Authenticator().loginWithGoogle();
              result.log();
            },
            child: const Text('login with Google'),
          ),
        ],
      ),
    );
  }
}
