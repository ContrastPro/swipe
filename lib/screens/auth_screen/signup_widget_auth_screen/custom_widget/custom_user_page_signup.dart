import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/format/phone_format.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/custom_widget/gradient_text_field.dart';

class CustomUserPageSignUp extends StatelessWidget {
  final ValueChanged<UserBuilder> onSubmit;

  static double boxHeight = 14.0;
  static UserBuilder userBuilder = UserBuilder();
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  const CustomUserPageSignUp({
    Key key,
    @required this.onSubmit,
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
            children: [
              AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
              SizedBox(height: 42.0),
              GradientTextField(
                hintText: "Имя",
                keyboardType: TextInputType.name,
                onChanged: (String value) {
                  userBuilder.name = value;
                },
                formatter: [
                  FilteringTextInputFormatter.deny(RegExp(' ')),
                ],
                validator: (String value) {
                  if (value.isEmpty) return '';
                  return null;
                },
              ),
              SizedBox(height: boxHeight),
              GradientTextField(
                hintText: "Фамилия",
                keyboardType: TextInputType.name,
                onChanged: (String value) {
                  userBuilder.lastName = value;
                },
                formatter: [
                  FilteringTextInputFormatter.deny(RegExp(' ')),
                ],
                validator: (String value) {
                  if (value.isEmpty) return '';
                  return null;
                },
              ),
              SizedBox(height: boxHeight),
              GradientTextField(
                hintText: "Телефон",
                keyboardType: TextInputType.phone,
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
                ],
                onChanged: (String value) {
                  userBuilder.phone = value;
                },
                validator: (String value) {
                  if (value.isEmpty) return '';
                  return null;
                },
              ),
              SizedBox(height: boxHeight),
              GradientTextField(
                hintText: "Электронная почта",
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {
                  userBuilder.email = value;
                },
                formatter: [
                  FilteringTextInputFormatter.deny(RegExp(' ')),
                ],
                validator: (value) {
                  if (value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return '';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              GradientButton(
                maxWidth: 280.0,
                minHeight: 50.0,
                borderRadius: 10.0,
                title: "Далее",
                onTap: () {
                  if (formKey.currentState.validate()) {
                    userBuilder.phone = PhoneFormat.formatPhone(
                      phone: userBuilder.phone,
                    );
                    onSubmit(userBuilder);
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
