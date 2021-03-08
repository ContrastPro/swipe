import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/screens/auth_screen/custom_widget/otp_field_auth.dart';
import 'package:swipe/screens/auth_screen/custom_widget/text_info_auth.dart';

class OTPPageSignIn extends StatelessWidget {
  final ValueChanged<String> onCompleted;

  const OTPPageSignIn({
    Key key,
    @required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
            SizedBox(height: 10.0),
            TextInfoAuth(
              title: "Введите код который мы отправили "
                  "на указаный вами номер телефона",
            ),
            Container(
              width: 280.0,
              child: OTPField(
                length: 6,
                width: 280.0,
                fieldWidth: 35.0,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                keyboardType: TextInputType.number,
                onCompleted: (smsCode) => onCompleted(smsCode),
              ),
            ),
            SizedBox(height: 40.0),
            GradientButton(
              title: "Вход",
              maxWidth: 280.0,
              minHeight: 50.0,
              borderRadius: 10.0,
              onTap: () {},
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
