import 'package:firstapp/home/home.dart';
import 'package:firstapp/login/login.dart';
import 'package:firstapp/prof/prof.dart';
import 'package:firstapp/prof/projects.dart';
import 'package:firstapp/profile/profile.dart';
import 'package:firstapp/about/about.dart';
import 'package:firstapp/news/news.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => ProfileScreen(),
  '/about': (context) => const AboutScreen(),
  '/news': (context) => const News(),
  '/project': (context) => const ProjectScreen(),
  '/profscreen': (context) => ProfScreen(),
};
