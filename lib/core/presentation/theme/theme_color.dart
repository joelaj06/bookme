import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeColor {
  MaterialColor get primary;
  MaterialColor get accent;
  MaterialColor get hint;
  Color get secondary;

  Color get success;
  Color get error;

  Color get grey;
  Color get yellow;
  Color get blue;

  Color get lightRed;
  Color get lightBlue;
  Color get lightYellow;
  Color get lightGreen;

  Color get darkRed;
  Color get darkBlue;
  Color get darkYellow;
  Color get darkGreen;

  Color get background;
  Color get background40;
  Color get hintLight;
  Color get text;
  Color get textDark;
  Color get overlay30;
  Color get overlay50;
  Color get overlay70;
  SystemUiOverlayStyle get statusBar;
  Brightness get brightness;
  Color get shadowColor;
}
