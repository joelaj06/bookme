import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/theme/secondary_color.dart';
import 'package:bookme/core/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppLightTheme implements ThemeColor {
  static const Color _black = Color(0xFF212121);
  @override
  MaterialColor hint = HintColor.color;
  @override
  MaterialColor accent = SecondaryColor.secondaryAccent;
  @override
  MaterialColor primary = PrimaryColor.color;

  @override
  Color success = const Color(0xFF0FC578);
  @override
  Color secondary = SecondaryColor.color;
  @override
  Color error = const Color(0xFFD20000);

  @override
  Color background = PrimaryColor.backgroundColor;
  @override
  Color background40 = const Color(0xFFF4F5F7);

  @override
  Color hintLight = const Color(0xFFD7D7D7);

  @override
  Color text =  const Color(0xff303134);
  @override
  Color textDark = const Color(0xFF4A4B65);

  @override
  Color grey = const Color(0xFF475B64);
  @override
  Color yellow = const Color(0xFFFCC019);
  @override
  Color blue = const Color(0xFF132DB0);

  @override
  Color lightRed = const Color(0xFFFFDBDB);
  @override
  Color lightBlue = const Color(0xFFECF3FF);
  @override
  Color lightYellow = const Color(0xFFF9F3E4);
  @override
  Color lightGreen = const Color(0xFFE3FFEF);

  @override
  Color darkRed = const Color(0xFFD20000);
  @override
  Color darkBlue = const Color(0xFF004E92);
  @override
  Color darkYellow = const Color(0xFFAA7503);
  @override
  Color darkGreen = const Color(0xFF37CF76);

  @override
  Color overlay30 = _black.withOpacity(.3);
  @override
  Color overlay50 = _black.withOpacity(.5);
  @override
  Color overlay70 = _black.withOpacity(.7);

  @override
  Brightness brightness = Brightness.light;
  @override
  SystemUiOverlayStyle statusBar =
  SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
  @override
  Color shadowColor = HintColor.color.shade50;
}
