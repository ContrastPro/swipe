import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/authentication_screen/provider/authentication_provider.dart';
import 'package:swipe/authentication_screen/custom_widget/signin_widget.dart';
import 'package:swipe/authentication_screen/custom_widget/signup_widget.dart';

class AuthenticationScreen extends StatelessWidget {
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
