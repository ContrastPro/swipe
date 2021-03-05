import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/screens/auth_screen/custom_widget/switch_auth_widget.dart';
import 'package:swipe/screens/auth_screen/custom_widget/text_info_auth.dart';
import 'package:swipe/screens/auth_screen/provider/auth_mode_provider.dart';

class SignUpWidgetAuthScreen extends StatefulWidget {
  @override
  _SignUpWidgetAuthScreenState createState() => _SignUpWidgetAuthScreenState();
}

class _SignUpWidgetAuthScreenState extends State<SignUpWidgetAuthScreen> {
  final Duration _duration = Duration(milliseconds: 1000);
  final Curve _curve = Curves.easeInOutQuint;
  PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  Widget _firstPage(AuthModeNotifier authModeNotifier) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
            TextInfoAuth(
              title: "Пройди регистрацию, чтобы открыть доступ "
                  "к самой полной базе рынка квартир в Сочи!",
            ),
            GradientButton(
              title: "Регистрация",
              maxWidth: 280.0,
              minHeight: 50.0,
              borderRadius: 10.0,
              onTap: () => _nextPage(),
            ),
            SwitchAuthWidget(),
          ],
        ),
      ),
    );
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
              default:
                return false;
            }
          },
          child: PageView(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: [
              _firstPage(authNotifier),
              Container(color: Colors.blue),
              Container(color: Colors.green),
            ],
          ),
        );
      },
    );
  }
}
