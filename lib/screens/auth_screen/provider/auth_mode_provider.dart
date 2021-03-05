import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum AuthMode { SIGNUP, SIGNIN }

class AuthModeNotifier with ChangeNotifier {
  final PageController _controller = PageController();
  final Duration _duration = Duration(milliseconds: 1000);
  final Curve _curve = Curves.easeInOutQuint;

  AuthMode _authMode = AuthMode.SIGNIN;

  PageController get pageController => _controller;

  Duration get duration => _duration;

  Curve get curve => _curve;

  AuthMode get authMode => _authMode;

  void changeAuthMode() {
    switch (_authMode) {
      case AuthMode.SIGNIN:
        _authMode = AuthMode.SIGNUP;
        _controller.nextPage(
          duration: _duration,
          curve: _curve,
        );
        break;
      case AuthMode.SIGNUP:
        _authMode = AuthMode.SIGNIN;
        _controller.previousPage(
          duration: _duration,
          curve: _curve,
        );
        break;
    }
    notifyListeners();
  }
}
