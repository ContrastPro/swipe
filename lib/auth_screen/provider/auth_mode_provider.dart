import 'package:flutter/foundation.dart';

enum AuthMode { SIGNUP, SIGNIN }

class AuthModeNotifier with ChangeNotifier {
  AuthMode _authMode = AuthMode.SIGNIN;

  AuthMode get authMode => _authMode;

  void changeAuthMode() {
    switch (_authMode) {
      case AuthMode.SIGNIN:
        _authMode = AuthMode.SIGNUP;
        break;
      case AuthMode.SIGNUP:
        _authMode = AuthMode.SIGNIN;
        break;
    }
    notifyListeners();
  }
}
