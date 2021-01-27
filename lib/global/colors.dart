import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF5F5F5);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF27AEA4);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0B3138),
      Color(0xFF0A4A46),
    ],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF56C385),
      Color(0xFF41BFB5),
    ],
  );

  static const LinearGradient textFieldGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF27AE63),
      Color(0xFF27AE9E),
    ],
  );
}
