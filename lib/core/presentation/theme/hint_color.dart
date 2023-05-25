import 'package:flutter/material.dart';

class HintColor{
  HintColor._();
  static const MaterialColor color = MaterialColor(_hintPrimaryValue, <int, Color>{
    50: Color(0xFFE7E8E8),
    100: Color(0xFFC4C6C6),
    200: Color(0xFF9DA1A0),
    300: Color(0xFF757B7A),
    400: Color(0xFF585E5E),
    500: Color(_hintPrimaryValue),
    600: Color(0xFF343C3B),
    700: Color(0xFF2C3332),
    800: Color(0xFF252B2A),
    900: Color(0xFF181D1C),
  });
  static const int _hintPrimaryValue = 0xFF3A4241;

  static const MaterialColor hintAccent = MaterialColor(_hintAccentValue, <int, Color>{
    100: Color(0xFF6CF9D6),
    200: Color(_hintAccentValue),
    400: Color(0xFF00FFBF),
    700: Color(0xFF00E6AC),
  });
  static const int _hintAccentValue = 0xFF3BF7C8;
}