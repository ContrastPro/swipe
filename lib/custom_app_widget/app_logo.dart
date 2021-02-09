import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;

  const AppLogo({
    Key key,
    this.width = 70.0,
    this.height = 45.0,
    this.fontSize = 55.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF27AE60).withAlpha(80),
                    Color(0xFF27AEA6).withAlpha(80),
                  ],
                ),
              ),
            ),
            Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.buttonGradient,
              ),
            ),
          ],
        ),
        SizedBox(width: 20),
        Text(
          "свайп",
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
