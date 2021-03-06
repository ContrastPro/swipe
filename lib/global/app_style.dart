import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData light() {
    return ThemeData(
      // Define the default brightness.
      brightness: Brightness.light,
      primaryColorBrightness: Brightness.light,

      // Define the default colors.
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      accentColor: AppColors.accentColor,

      // Cursor Color for iOS
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: AppColors.accentColor,
      ),

      // Cursor Color for others(Android, Fuchsia)
      cursorColor: AppColors.accentColor,

      // The color of the handles used to adjust what part of the text is
      // currently selected.
      textSelectionHandleColor: AppColors.accentColor,

      // Define the default font family.
      fontFamily: 'Montserrat',
    );
  }
}
