import 'package:bookme/core/presentation/theme/theme_color.dart';
import 'package:flutter/material.dart';

import 'fonts.dart';

class AppTheme{
   AppTheme(this.colors);
   ThemeColor colors;

   ThemeData get data => ThemeData(
      fontFamily: AppFonts.poppins,
      primaryColorLight: colors.primary,
      primarySwatch: colors.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      backgroundColor: colors.background,
      errorColor: colors.error,
      primaryIconTheme: IconThemeData(
         color: colors.primary,
      ),
      colorScheme: ColorScheme.fromSwatch(
         primarySwatch: colors.primary,
         primaryColorDark: colors.primary.shade900,
         accentColor: colors.accent,
         cardColor: colors.background,
         backgroundColor: colors.background,
         errorColor: colors.error,
         brightness: colors.brightness,
      ),
      focusColor: colors.primary,
      primaryColor: colors.primary,
      brightness: colors.brightness,
      scaffoldBackgroundColor: colors.background,
      unselectedWidgetColor: colors.lightBlue,
      disabledColor: colors.lightBlue,
      tabBarTheme: TabBarTheme(
         indicatorSize: TabBarIndicatorSize.tab,
         unselectedLabelColor: colors.textDark,
         labelColor: Colors.white,
         indicator: BoxDecoration(
           // borderRadius: AppBorderRadius.button,
            color: colors.primary,
         ),
      ),

      appBarTheme: AppBarTheme(
         centerTitle: true,
         backgroundColor: Colors.transparent,
         elevation: 0.0,
         titleTextStyle:TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: colors.secondary,
            fontFamily: AppFonts.poppins,
         ),
         iconTheme: IconThemeData(
            color: colors.secondary,
         ),
      ),
      iconTheme: IconThemeData(
         color: colors.text,
      ),
      buttonTheme: const ButtonThemeData(
         textTheme: ButtonTextTheme.primary,
         height: 50,
      ),
      indicatorColor: colors.primary,
      toggleableActiveColor: colors.text,
      canvasColor: colors.background,
      /*inputDecorationTheme: InputDecorationTheme(
          focusColor: colors.text,
          labelStyle: body1.copyWith(
            height: 1.8,
            fontWeight: FontWeight.w800,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppBorderRadius.largeAll,
            borderSide: BorderSide(
              color: colors.primary.shade100,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.largeAll,
              borderSide: BorderSide(
                color: colors.primary.shade100,
              )),
          disabledBorder: OutlineInputBorder(
            borderRadius: AppBorderRadius.largeAll,
            borderSide: BorderSide(
              color: colors.hintLight,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colors.primary.shade100,
              width: 0.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: AppBorderRadius.largeAll,
            borderSide: BorderSide(
              color: colors.primary.shade100,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          fillColor: Colors.transparent,
          errorStyle: TextStyle(
            color: colors.error,
            fontSize: 12,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          alignLabelWithHint: true,
          hintStyle: body1.copyWith(
            color: colors.hint,
            height: 1.2,
          ),
        ),*/
   );
}