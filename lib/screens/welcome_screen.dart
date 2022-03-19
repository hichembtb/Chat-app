import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String route = "welcome";
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animation = ColorTween(
      begin: Colors.black,
      end: const Color.fromARGB(255, 20, 29, 36),
    ).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: "logo",
                  child: SizedBox(
                    child: Image.asset("images/logo.png"),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  textAlign: TextAlign.center,
                  text: const ["Chat Ly"],
                  totalRepeatCount: 1,
                  repeatForever: false,
                  textStyle: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: "Log In",
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.route);
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: "Register",
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
