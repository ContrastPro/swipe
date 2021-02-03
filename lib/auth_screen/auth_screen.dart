import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/auth_screen/custom_widget/signin_widget.dart';
import 'package:swipe/auth_screen/custom_widget/signup_widget.dart';
import 'package:swipe/auth_screen/provider/auth_mode_provider.dart';
import 'package:swipe/auth_screen/provider/auth_signin_provider.dart';
import 'package:swipe/auth_screen/provider/auth_signup_provider.dart';

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
          child: Consumer<AuthModeNotifier>(
            builder: (context, authNotifier, child) {
              return ChangeNotifierProvider<AuthSignUpNotifier>(
                create: (_) => AuthSignUpNotifier(),
                child: SignUpWidget(),
              );
             /* return AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: authNotifier.authMode == AuthMode.SIGNIN
                    ? ChangeNotifierProvider<AuthSignInNotifier>(
                        create: (_) => AuthSignInNotifier(),
                        child: SignInWidget(),
                      )
                    : ChangeNotifierProvider<AuthSignUpNotifier>(
                        create: (_) => AuthSignUpNotifier(),
                        child: SignUpWidget(),
                      ),
              );*/
            },
          ),
        ),
      ),
    );
  }
}
