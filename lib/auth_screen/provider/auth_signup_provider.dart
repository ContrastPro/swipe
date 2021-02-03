import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swipe/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/custom_app_widget/notification_dialog.dart';

class AuthSignUpNotifier with ChangeNotifier {
  bool _startLoading = false;
  String _smsPin;
  AuthFirebaseAPI _authFirebaseAPI;

  bool get startLoading => _startLoading;

  AuthFirebaseAPI get authFirebaseAPI => _authFirebaseAPI;

  set smsPin(String value) => _smsPin = value;

  Future<void> signUpWithPhoneNumber({
    BuildContext context,
    String firstName,
    String phone,
    String email,
  }) async {
    FocusScope.of(context).unfocus();
    if (firstName != "" && phone != "" && email != "") {
      _authFirebaseAPI = AuthFirebaseAPI();
      _changeLoading(true);
      String splitPhone = _autoEditPhoneNumber(phone);
      print(splitPhone);

      await _authFirebaseAPI.signUpWithPhoneNumber(phone: splitPhone);

      if (_authFirebaseAPI.status == AuthStatus.EXIST) {
        _showDialog(context, _authFirebaseAPI.message);
      }
      _changeLoading(false);
    } else {
      _showDialog(context, "Похоже вы забыли кое-что указать");
    }
  }

  void enterWithCredential({BuildContext context}) async {
    if (_smsPin != null && _smsPin.length == 6) {
      _changeLoading(true);
      await _authFirebaseAPI.enterWithCredential(smsCode: _smsPin);
      if (_authFirebaseAPI.status == AuthStatus.ERROR) {
        _changeLoading(false);
        _showDialog(context, _authFirebaseAPI.message);
      }
    }
  }

  bool phoneIsNotExist() {
    if (_authFirebaseAPI != null &&
        _authFirebaseAPI.status == AuthStatus.NOTEXIST) {
      return true;
    } else {
      return false;
    }
  }

  String _autoEditPhoneNumber(String phone) {
    String splitPhone = phone.split(" ").join("");
    if (splitPhone.contains("+")) {
      return splitPhone;
    } else {
      return "+$splitPhone";
    }
  }

  void _showDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return NotificationDialog(
          title: 'Упс...',
          content: content,
        );
      },
    );
  }

  void _changeLoading(bool current) {
    _startLoading = current;
    notifyListeners();
  }
}
