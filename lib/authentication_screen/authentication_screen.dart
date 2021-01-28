import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/authentication_screen/authentication_provider.dart';
import 'package:swipe/authentication_screen/signin_widget.dart';
import 'package:swipe/authentication_screen/signup_widget.dart';
import 'package:swipe/custom_widget/app_logo_widget.dart';
import 'package:swipe/global/app_colors.dart';

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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppLogo(width: 70.0, height: 45.0, fontSize: 55.0),
                  authNotifier.authMode == AuthMode.SIGNIN
                      ? SignInWidget()
                      : SignUpWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/*class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  AuthMode _authMode;

  @override
  void initState() {
    _authMode = AuthMode.SIGNIN;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppLogo(width: 70.0, height: 45.0, fontSize: 55.0),
              _authMode == AuthMode.SIGNIN ? SignInWidget() : SignUpWidget(),
            ],
          ),
        ),
      ),
    );
  }
}*/
