import 'package:flutter/material.dart';
import 'package:swipe/authentication_screen/switch_auth_widget.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return SwitchAuthWidget();
  }
}
