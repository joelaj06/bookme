import 'package:flutter/material.dart';

class PrimaryColor{
  PrimaryColor._();
  static const MaterialColor color = MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFFEF0E3),
    100: Color(0xFFFCD9B9),
    200: Color(0xFFFBC08A),
    300: Color(0xFFF9A65B),
    400: Color(0xFFF79337),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFFF57812),
    700: Color(0xFFF36D0E),
    800: Color(0xFFF2630B),
    900: Color(0xFFEF5006),
  });
  static const int _primaryPrimaryValue = 0xFFF68014;

  static const Color backgroundColor = Color(0xFFFEFEFE);

  static const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_primaryAccentValue),
    400: Color(0xFFFFC6B1),
    700: Color(0xFFFFB397),
  });
  static const int _primaryAccentValue = 0xFFFFEBE4;
}

