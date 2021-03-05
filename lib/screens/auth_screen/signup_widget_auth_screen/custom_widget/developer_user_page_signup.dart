import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';

class DeveloperUserPageSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
            SizedBox(height: 50.0),
            Text("Developer User"),
            //SwitchAuthWidget(),
          ],
        ),
      ),
    );
  }
}
