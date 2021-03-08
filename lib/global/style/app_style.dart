import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/global/style/app_colors.dart';

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
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.accentColor,
        selectionColor: AppColors.accentColor.withOpacity(0.2),
        selectionHandleColor: AppColors.accentColor,
      ),

      // Define the default font family.
      fontFamily: 'Montserrat',
    );
  }
}
