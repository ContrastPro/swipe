import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/global/style/app_colors.dart';
import 'package:swipe/global/firebase_api.dart';

class BannedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
            SizedBox(height: 60.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Ваш аккаунт временно заблокирован",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            GradientButton(
              title: "Выйти",
              maxWidth: 280.0,
              minHeight: 50.0,
              borderRadius: 10.0,
              onTap: () => FirebaseAPI.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
