import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';

class OTPPageSignUp extends StatelessWidget {
  final ValueChanged<String> onSubmit;

  const OTPPageSignUp({
    Key key,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
            SizedBox(height: 42.0),
          ],
        ),
      ),
    );
  }
}
