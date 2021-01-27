import 'package:flutter/material.dart';
import 'package:swipe/global/colors.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: 70,
              height: 45,
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
              width: 45,
              height: 45,
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
            fontSize: 55,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
