import 'package:flutter/material.dart';

class SecondaryColor{
  static const MaterialColor color = MaterialColor(_secondaryPrimaryValue, <int, Color>{
    50: Color(0xFFE3E4E4),
    100: Color(0xFFB9BCBC),
    200: Color(0xFF8B9090),
    300: Color(0xFF5D6463),
    400: Color(0xFF3A4241),
    500: Color(_secondaryPrimaryValue),
    600: Color(0xFF141D1C),
    700: Color(0xFF111818),
    800: Color(0xFF0D1413),
    900: Color(0xFF070B0B),
  });
  static const int _secondaryPrimaryValue = 0xFF172120;

  static const MaterialColor secondaryAccent = MaterialColor(_secondaryAccentValue, <int, Color>{
    100: Color(0xFF52FFFF),
    200: Color(_secondaryAccentValue),
    400: Color(0xFF00EBEB),
    700: Color(0xFF00D1D1),
  });
  static const int _secondaryAccentValue = 0xFF1FFFFF;
}