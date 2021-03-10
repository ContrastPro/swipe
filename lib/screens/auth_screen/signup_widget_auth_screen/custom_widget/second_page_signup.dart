import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/screens/auth_screen/custom_widget/switch_auth_widget.dart';

import 'signup_icon_signup.dart';

class SecondPageSignUp extends StatelessWidget {
  final VoidCallback onDeveloperUserTap;
  final VoidCallback onCustomUserTap;

  const SecondPageSignUp({
    Key key,
    @required this.onDeveloperUserTap,
    @required this.onCustomUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
            /*SizedBox(height: 50.0),
            SignUpIconSignUp(
              iconPath: "assets/images/building.png",
              width: 100.0,
              height: 100.0,
              title: "Я застройщик",
              onTap: () => onDeveloperUserTap(),
            ),*/
            SizedBox(height: 40.0),
            SignUpIconSignUp(
              iconPath: "assets/images/neighborhood.png",
              width: 130.0,
              height: 65.0,
              title: "Я частное лицо",
              onTap: () => onCustomUserTap(),
            ),
            SizedBox(height: 40.0),
            SwitchAuthWidget(),
          ],
        ),
      ),
    );
  }
}
