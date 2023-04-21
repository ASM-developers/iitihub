import 'dart:ffi';
import 'dart:ui';

import 'package:firstapp/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:google_fonts/google_fonts.dart';
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.1, 1),
            colors: <Color>[
              Color(0xFF000000),
              Color(0xFF020202),
              Color(0xFF040404),
              Color(0xFF060606),
              Color(0xFF080808),
              Color(0xFF101010),
              Color(0xFF121212),
              Color(0xFF141414),
              Color(0xFF161616),
              Color(0xFF181818),
              Color(0xFF202020),
              Color(0xFF222222),
              Color(0xFF242424),
              Color(0xFF262626),
              Color(0xFF282828),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: AssetImage('assets/images/Transperant_IITI.png'),
              width: 150,
            ),
            SizedBox(
              width: double.infinity,
              height: 30,
            ),
            LoginButton(
              color: Colors.red,
              icon: FontAwesomeIcons.gem,
              text: 'Continue as Guest',
              loginMethod: AuthService().anonLogin,
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            LoginButton(
              color: Colors.black,
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
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.black54),
          elevation: MaterialStatePropertyAll<double>(25),
          surfaceTintColor: MaterialStatePropertyAll<Color>(Colors.white),
          padding:
              MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(30)),
          // textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(color: Colors.red)),
        ),
        icon: Icon(
          icon,
          color: Colors.white70,
          size: 20,
        ),
        onPressed: () => loginMethod(),
        label: Text(
          this.text,
          style: TextStyle(
            color: Colors.grey.shade100,
            fontSize: 20,
            height: 1.1,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
