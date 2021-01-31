import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthMode { SIGNUP, SIGNIN }

class AuthNotifier with ChangeNotifier {
  User _user;
  AuthMode _authMode = AuthMode.SIGNIN;

  User get user => _user;

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

  void setUser(User user) {
    _user = user ;
    notifyListeners();
  }
}
