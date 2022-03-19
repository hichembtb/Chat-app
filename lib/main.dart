import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      initialRoute: WelcomeScreen.route,
      routes: {
        WelcomeScreen.route: (context) => const WelcomeScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        RegistrationScreen.route: (context) => const RegistrationScreen(),
        ChatScreen.route: (context) => const ChatScreen(),
      },
    );
  }
}
