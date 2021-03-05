import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/custom_widget/snackbar_message_auth.dart';
import 'package:swipe/screens/auth_screen/provider/auth_mode_provider.dart';

import 'api/signup_firestore_api.dart';
import 'custom_widget/custom_user_page_signup.dart';
import 'custom_widget/developer_user_page_signup.dart';
import 'custom_widget/first_page_signup.dart';
import 'custom_widget/second_page_signup.dart';

class SignUpWidgetAuthScreen extends StatefulWidget {
  @override
  _SignUpWidgetAuthScreenState createState() => _SignUpWidgetAuthScreenState();
}

class _SignUpWidgetAuthScreenState extends State<SignUpWidgetAuthScreen> {
  final Duration _duration = Duration(milliseconds: 1000);
  final Curve _curve = Curves.easeInOutQuint;
  PageController _controller;
  bool _startLoading = false;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    _controller.nextPage(
      duration: _duration,
      curve: _curve,
    );
  }

  void _previousPage() {
    _controller.previousPage(
      duration: _duration,
      curve: _curve,
    );
  }

  void _signUpCustomUser({
    @required AuthModeNotifier authNotifier,
    @required UserBuilder userBuilder,
  }) async {
    //log("$userBuilder");
    setState(() => _startLoading = true);
    switch (await SignUpFirestoreAPI.signUpCustomUser(userBuilder)) {
      case SignUpStatus.EXIST:
        setState(() => _startLoading = false);
        SnackBarMessageAuth.showSnackBar(
          context: context,
          content: "Аккаунт с таким номером телефона уже существует.",
          action: "Войти",
          onPressed: () {
            authNotifier.changeAuthMode();
          },
        );
        break;
      default:
        // Начинаем проходить регистрацию и если возникает ошибка выводим

        setState(() => _startLoading = false);
        SnackBarMessageAuth.showSnackBar(
          context: context,
          content: "Указаный вами номер неверного формата.",
        );
        break;
    }
  }

  Widget _buildScreen(AuthModeNotifier authNotifier) {
    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            /*FirstPageSignUp(
              onTap: () => _nextPage(),
            ),
            SecondPageSignUp(
              onDeveloperUserTap: () {
                _controller.animateToPage(
                  2,
                  duration: _duration,
                  curve: _curve,
                );
              },
              onCustomUserTap: () {
                _controller.animateToPage(
                  3,
                  duration: _duration,
                  curve: _curve,
                );
              },
            ),
            DeveloperUserPageSignUp(),*/
            CustomUserPageSignUp(
              onSubmit: (UserBuilder userBuilder) => _signUpCustomUser(
                authNotifier: authNotifier,
                userBuilder: userBuilder,
              ),
            ),
          ],
        ),
        if (_startLoading == true) WaveIndicator(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModeNotifier>(
      builder: (context, authNotifier, child) {
        return WillPopScope(
          onWillPop: () async {
            switch (_controller.page.toInt()) {
              case 0:
                authNotifier.changeAuthMode();
                return false;
              case 1:
                _previousPage();
                return false;
              case 2:
                _previousPage();
                return false;
              case 3:
                _controller.animateToPage(
                  1,
                  duration: _duration,
                  curve: _curve,
                );
                return false;
              default:
                return false;
            }
          },
          child: _buildScreen(authNotifier),
        );
      },
    );
  }
}
