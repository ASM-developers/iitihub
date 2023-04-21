import 'package:firstapp/home/home.dart';
import 'package:firstapp/login/login.dart';
import 'package:firstapp/profile/profile.dart';
import 'package:firstapp/about/about.dart';
import 'package:firstapp/home/news.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => ProfileScreen(),
  '/about': (context) => const AboutScreen(),
  '/news': (context) => News(),
};
