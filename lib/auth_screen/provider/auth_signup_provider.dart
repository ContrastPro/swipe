import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swipe/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/custom_app_widget/notification_dialog.dart';
import 'package:swipe/model/custom_user.dart';

class AuthSignUpNotifier with ChangeNotifier {
  bool _startLoading = false;
  String _verificationId;
  String _smsPin;
  AuthFirebaseAPI _authFirebaseAPI;
  UserBuilder _userBuilder;

  bool get startLoading => _startLoading;

  AuthFirebaseAPI get authFirebaseAPI => _authFirebaseAPI;

  set userBuilder(UserBuilder value) => _userBuilder = value;

  set setVerificationId(String value) => _verificationId = value;

  set smsPin(String value) => _smsPin = value;

  Future<String> signUpWithPhoneNumber({BuildContext context}) async {
    FocusScope.of(context).unfocus();
    String splitPhone;
    if (_userBuilder.phone != null && _userBuilder.phone != "") {
      _changeLoading(true);
      splitPhone = _autoEditPhoneNumber(_userBuilder.phone);
      _authFirebaseAPI = AuthFirebaseAPI();

      await _authFirebaseAPI.signUpWithPhoneNumber(phone: splitPhone);

      if (_authFirebaseAPI.status == AuthStatus.EXIST) {
        _showDialog(context, _authFirebaseAPI.message);
      }
      _changeLoading(false);
    } else {
      _showDialog(context, "Похоже вы забыли кое-что указать");
    }
    return splitPhone;
  }

  void enterWithCredential({BuildContext context}) async {
    if (_smsPin != null && _smsPin.length == 6) {
      _changeLoading(true);
      await _authFirebaseAPI.enterWithCredential(
        verificationId: _verificationId,
        smsCode: _smsPin,
        customUser: CustomUser(builder: _userBuilder),
      );
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
      _userBuilder.phone = splitPhone;
      return splitPhone;
    } else {
      _userBuilder.phone = "+$splitPhone";
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
