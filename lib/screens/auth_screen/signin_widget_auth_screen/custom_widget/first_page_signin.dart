import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/screens/auth_screen/custom_widget/switch_auth_widget.dart';
import 'package:swipe/screens/auth_screen/custom_widget/text_info_auth.dart';

class FirstPageSignIn extends StatelessWidget {
  final VoidCallback onTap;

  const FirstPageSignIn({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
            TextInfoAuth(
              title: "Открой доступ к самой полной "
                  "базе рынка квартир в Сочи!",
            ),
            GradientButton(
              title: "Войти",
              maxWidth: 280.0,
              minHeight: 50.0,
              borderRadius: 10.0,
              onTap: () => onTap(),
            ),
            SwitchAuthWidget(),
          ],
        ),
      ),
    );
  }
}
