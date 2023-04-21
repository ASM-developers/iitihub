import 'package:firstapp/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//TODO : add a modal onClick to a button. Next we add a

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
              child: LoginButton(
                color: Colors.deepPurple,
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as Guest',
                loginMethod: AuthService().anonLogin,
              ),
            ),
            LoginButton(
              color: Colors.blue,
              icon: FontAwesomeIcons.google,
              text: 'Continue via google',
              loginMethod: AuthService().googleLogin,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     showMyModal(context);
            //   },
            //   child: Text('Show Modal'),
            // ),
          ],
        ),
      ),
    );
  }
}

//make a class which returns a button given login method, color, string and icon

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final loginMethod;
  const LoginButton({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.loginMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => loginMethod(),
        label: Text(this.text),
      ),
    );
  }
}
