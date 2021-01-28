import 'package:flutter/foundation.dart';

enum AuthMode { SIGNUP, SIGNIN }

class AuthNotifier with ChangeNotifier {
  AuthMode authMode = AuthMode.SIGNIN;

  void changeAuthMode() {
    switch (authMode) {
      case AuthMode.SIGNIN:
        authMode = AuthMode.SIGNUP;
        break;
      case AuthMode.SIGNUP:
        authMode = AuthMode.SIGNIN;
        break;
    }
    notifyListeners();
  }
}
