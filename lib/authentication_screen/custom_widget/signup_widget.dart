import 'package:flutter/material.dart';
import 'package:swipe/authentication_screen/custom_widget/switch_auth_widget.dart';
import 'package:swipe/custom_app_widget/app_logo_widget.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
          SwitchAuthWidget(),
        ],
      ),
    );
  }
}
