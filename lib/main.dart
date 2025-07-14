import 'package:facebook_clone_in_flutter/features/auth/presentation/screens/create_account_screee.dart';
import 'package:facebook_clone_in_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:facebook_clone_in_flutter/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/screens/home_screen.dart';
import 'core/screens/loader.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          if (snapshot.hasData) {
            final user = snapshot.data;

            if (user != null && user.emailVerified) {
              return const HomeScreen();
            } else {
              return const VerifyEmailScreen();
            }
          } else {
            return const LoginScreen();
            //return const CreateAccountScreen();
          }
        },
      ),
    );
  }
}
