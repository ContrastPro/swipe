import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swipe/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/custom_app_widget/notification_dialog.dart';

class AuthSignInNotifier with ChangeNotifier {
  bool _startLoading = false;
  AuthFirebaseAPI _authFirebaseAPI;

  bool get startLoading => _startLoading;

  AuthFirebaseAPI get authFirebaseAPI => _authFirebaseAPI;

  Future<void> signInWithPhoneNumber(
      {BuildContext context, String phone}) async {
    FocusScope.of(context).unfocus();
    _changeLoading(true);
    _authFirebaseAPI = AuthFirebaseAPI();
    String splitPhone = _autoEditPhoneNumber(phone);

    await _authFirebaseAPI.signInWithPhoneNumber(phone: splitPhone);
    if (_authFirebaseAPI.status == AuthStatus.NOTEXIST) {
      _showDialog(context, _authFirebaseAPI.message);
    }
    _changeLoading(false);
  }

  void enterWithCredential({BuildContext context, String smsPin}) async {
    if (smsPin != null && smsPin.length == 6) {
      _changeLoading(true);
      await _authFirebaseAPI.enterWithCredential(smsCode: smsPin);
      if (_authFirebaseAPI.status == AuthStatus.ERROR) {
        _changeLoading(false);
        _showDialog(context, _authFirebaseAPI.message);
      }
    }
  }

  bool phoneIsExist() {
    if (_authFirebaseAPI != null &&
        _authFirebaseAPI.status == AuthStatus.EXIST) {
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
