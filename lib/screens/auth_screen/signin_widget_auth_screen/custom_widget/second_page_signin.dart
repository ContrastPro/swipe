import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/format/phone_format.dart';
import 'package:swipe/screens/auth_screen/custom_widget/gradient_text_field.dart';

class SecondPageSignIn extends StatelessWidget {
  final ValueChanged<String> onCompleted;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static String phone;

  const SecondPageSignIn({
    Key key,
    @required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
              SizedBox(height: 40.0),
              GradientTextField(
                hintText: "Телефон",
                keyboardType: TextInputType.phone,
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
                ],
                onChanged: (String value) {
                  phone = value;
                },
                validator: (String value) {
                  if (value.isEmpty) return '';
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              GradientButton(
                title: "Продолжить",
                maxWidth: 280.0,
                minHeight: 50.0,
                borderRadius: 10.0,
                onTap: () {
                  if (formKey.currentState.validate()) {
                    phone = PhoneFormat.formatPhone(
                      phone: phone,
                    );
                    onCompleted(phone);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
