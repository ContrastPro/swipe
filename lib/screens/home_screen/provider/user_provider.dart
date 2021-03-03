import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/model/custom_user.dart';

class UserNotifier with ChangeNotifier {
  bool _isHomeScreen;

  UserBuilder _userBuilder;

  bool get isHomeScreen => _isHomeScreen;

  UserBuilder get userProfile => _userBuilder;

  void setUserProfile({@required UserBuilder userBuilder}) async {
    _userBuilder = userBuilder;
    await _setHomeScreen();
    log("$_userBuilder");
    notifyListeners();
  }

  void changeRegularScreen({bool isRegularScreen}) async {
    _isHomeScreen = isRegularScreen;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRegularScreen', isRegularScreen);
    notifyListeners();
  }

  Future<void> _setHomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isRegularScreen') == true) {
      _isHomeScreen = prefs.getBool('isRegularScreen');
    } else {
      _isHomeScreen = true;
      prefs.setBool('isRegularScreen', _isHomeScreen);
    }
  }
}
