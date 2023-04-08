import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
  fontFamily: GoogleFonts.nunito().fontFamily,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 18, color: Colors.blue),
    bodyText2: TextStyle(
      fontSize: 16,
      letterSpacing: BorderSide.strokeAlignCenter,
    ),
    button: TextStyle(
      // color: Colors.red,
      letterSpacing: 2,
      fontWeight: FontWeight.bold,
    ),
  ),
);
