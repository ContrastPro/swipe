import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/style/app_colors.dart';

import 'provider/auth_mode_provider.dart';
import 'signin_widget_auth_screen/signin_widget_auth_screen.dart';
import 'signup_widget_auth_screen/signup_widget_auth_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          child: Consumer<AuthModeNotifier>(
            builder: (context, authNotifier, child) {
              return PageView(
                controller: authNotifier.pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SignInWidgetAuthScreen(
                    authNotifier: authNotifier,
                  ),
                  SignUpWidgetAuthScreen(
                    authNotifier: authNotifier,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
