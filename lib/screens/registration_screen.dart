import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/rounded_button.dart';
import '../helper/constants.dart';
import '../helper/show_snakcbar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String route = "registration";
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email, password;
  GlobalKey<FormState> formkey = GlobalKey();
  // Registration methode
  void createUserWithEmailAndPassword() async {
    setState(() {
      showSpinner = true;
    });
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Navigator.pushReplacementNamed(context, ChatScreen.route,
          arguments: email);
      setState(() {
        showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarError(
          context,
          "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        SnackBarError(
          context,
          "email already in use",
        );
      }
    } catch (e) {
      print(e);
    }
  }

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 100.0,
                ),
                Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset("images/logo.png"),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.length <= 2) {
                      return "email too short ";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: kTextFiledDecoration.copyWith(
                      hintText: "Enter your email"),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.length <= 2) {
                      return "password too short ";
                    }
                  },
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (val) {
                    password = val;
                  },
                  decoration: kTextFiledDecoration.copyWith(
                      hintText: "Enter your password"),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.blueAccent,
                  text: "Register",
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      createUserWithEmailAndPassword();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
