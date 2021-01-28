import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/authentication_screen/custom_widget/signin_widget.dart';
import 'package:swipe/authentication_screen/custom_widget/signup_widget.dart';
import 'package:swipe/authentication_screen/authentication_provider.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Consumer<AuthNotifier>(
            builder: (context, authNotifier, child) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: authNotifier.authMode == AuthMode.SIGNIN
                    ? SignInWidget()
                    : SignUpWidget(),
              );
            },
          ),
        ),
      ),
    );
  }
}
