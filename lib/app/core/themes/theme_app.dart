import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin ThemeApp {
  static ThemeData get light => ThemeData.light().copyWith(
        primaryColor: const Color.fromRGBO(53, 97, 120, 1),
        accentColor: const Color.fromRGBO(231, 130, 68, 1),
        textTheme: GoogleFonts.ralewayTextTheme(
          const TextTheme(
            headline1: TextStyle(
              fontSize: 98,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
              color: Colors.black,
            ),
            headline2: TextStyle(
              fontSize: 61,
              fontWeight: FontWeight.w300,
              letterSpacing: -0.5,
              color: Colors.black,
            ),
            headline3: TextStyle(
              fontSize: 49,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            headline4: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
              color: Colors.black,
            ),
            headline5: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15,
              color: Colors.black,
            ),
            subtitle1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.15,
              color: Colors.black,
            ),
            subtitle2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
              color: Colors.black,
            ),
            bodyText1: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
              color: Colors.black,
            ),
            button: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
              color: Colors.black,
            ),
            caption: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
              color: Colors.black,
            ),
            overline: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,
              color: Colors.black,
            ),
          ),
        ),
      );
}
