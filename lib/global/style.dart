import 'package:flutter/material.dart';
import 'package:swipe/global/colors.dart';

class AppTheme{
  static ThemeData light(){
    return ThemeData(
      // Define the default brightness.
      brightness: Brightness.light,
      primaryColorBrightness: Brightness.light,

      // Define the default colors.
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      accentColor: AppColors.accentColor,

      // Define the default font family.
      fontFamily: 'Montserrat',

      // Define the default TextTheme.

     /* textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, ),
      ),*/
    );
  }
}