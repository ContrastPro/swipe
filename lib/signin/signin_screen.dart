import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/custom_widget/app_logo.dart';
import 'package:swipe/global/colors.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  int _pageIndex = 0;

  Widget _buildTextInfo({String title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 40.0, 50.0, 60.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildButton({String title}) {
    return RaisedButton(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        switch (_pageIndex) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            break;
        }
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: AppColors.buttonGradient,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 280.0,
            minHeight: 45.0,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _firstPage() {
    return Column(
      children: [
        _buildTextInfo(
          title: "Открой доступ к самой полной базе рынка квартир в Сочи!",
        ),
        _buildButton(title: "Войти"),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Впервые у нас?",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Регистрация",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _secondPage() {
    return Column(
      children: [
        SizedBox(height: 20.0),
        _buildButton(title: "Далее"),
      ],
    );
  }

  Widget _thirdPage() {
    return Column(
      children: [
        _buildTextInfo(
          title: "Введите код, который мы отправили "
              "на указанный вами номер телефона",
        ),
        SizedBox(height: 20.0),
        _buildButton(title: "Войти"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppLogo(),
              _firstPage(),
            ],
          ),
        ),
      ),
    );
  }
}
