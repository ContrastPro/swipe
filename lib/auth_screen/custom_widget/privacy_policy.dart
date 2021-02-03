import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _normalStyle = TextStyle(
      fontWeight: FontWeight.w300,
      color: Colors.white,
      fontSize: 14.0,
    );

    TextStyle _boldStyle = TextStyle(
      fontWeight: FontWeight.w900,
      color: Colors.white,
      fontSize: 14.0,
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 45.0,
          vertical: 16.0,
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text:
                'Создавая Учетную запись в\nонлайн сервесе Swipe, Вы соглашаетесь c ',
            style: _normalStyle,
            children: <TextSpan>[
              TextSpan(
                text: 'Условиями использования',
                style: _boldStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //
                  },
              ),
              TextSpan(
                text: ', а также\n',
                style: _normalStyle,
              ),
              TextSpan(
                text: 'Политикой конфеденциальности',
                style: _boldStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
