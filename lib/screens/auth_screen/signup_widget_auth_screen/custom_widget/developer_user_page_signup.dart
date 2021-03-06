import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';

class DeveloperUserPageSignUp extends StatelessWidget {
  //final ValueChanged<String> onSubmit;

  final VoidCallback onSubmit;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  const DeveloperUserPageSignUp({
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
              SizedBox(height: 50.0),
              Text("Developer User"),
              GradientButton(
                maxWidth: 280.0,
                minHeight: 50.0,
                borderRadius: 10.0,
                title: "Далее",
                onTap: () {
                  onSubmit();
                  /*if (formKey.currentState.validate()) {
                    userBuilder.phone = PhoneFormat.formatPhone(
                      phone: userBuilder.phone,
                    );
                    onSubmit(userBuilder);
                  }*/
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
