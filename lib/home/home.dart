import 'package:flutter/material.dart';
import 'package:firstapp/profile/profile.dart';
import 'package:firstapp/login/login.dart';
import 'package:firstapp/services/auth.dart';
import 'package:firstapp/news/news.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('error'),
          );
        } else if (snapshot.hasData) {
          // return News();
          return ProfileScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
