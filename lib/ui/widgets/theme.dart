import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Color(0xFF00348d),
      accentColor: Color(0xFF6D2077),
      scaffoldBackgroundColor: Color(0xFF193857),
      backgroundColor: Color(0xFFF0F0F0),
      fontFamily: 'KPMG',
      textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: 'KPMG',
            fontSize: 36,
            height: 1,
            color: Color(0xFFFFFFFF),
          ),
          headline2: TextStyle(
              fontFamily: 'KPMG',
              fontSize: 36,
              height: 1,
              color: Color(0xFF000000),
              fontWeight: FontWeight.bold),
          headline3: TextStyle(
            fontFamily: 'Univers',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF005eb8),
          ),
          headline4: TextStyle(
              fontSize: 14,
              fontFamily: 'Univers',
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF)),
          headline5: TextStyle(
            fontSize: 14,
            fontFamily: 'Univers',
            color: Color(0xFFFFFFFF),
          ),
          headline6: TextStyle(
             fontSize: 14,
            fontFamily: 'Univers',
            color: Color(0xFF000000),
          ),
          button: TextStyle(
            fontFamily: 'Univers',
            fontSize: 14,
            color: Colors.white,
          )),
      buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF00348d),
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.primary));
}
