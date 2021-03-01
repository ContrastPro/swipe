import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/home_screen/api/home_firestore_api.dart';

class UserNotifier with ChangeNotifier {
  bool _isRegularScreen;
  bool _accessIsAllowed;
  UserBuilder _userBuilder;

  bool get isRegularScreen => _isRegularScreen;

  bool get accessIsAllowed => _accessIsAllowed;

  UserBuilder get userProfile => _userBuilder;

  void setUserProfile({@required UserBuilder userBuilder}) async {
    _userBuilder = userBuilder;
    await _setRegularScreen();
    log("$_userBuilder");
    notifyListeners();
  }

  void updateUserProfile() async {
    _userBuilder = await HomeFirestoreAPI.updateUserProfile();
    log("$_userBuilder");
    notifyListeners();
  }

  void setAccess(bool access) {
    _accessIsAllowed = access;
    notifyListeners();
  }

  void changeRegularScreen({bool isRegularScreen}) async {
    _isRegularScreen = isRegularScreen;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRegularScreen', isRegularScreen);
    notifyListeners();
  }

  Future<void> _setRegularScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isRegularScreen') == true) {
      _isRegularScreen = prefs.getBool('isRegularScreen');
    } else {
      _isRegularScreen = true;
      prefs.setBool('isRegularScreen', _isRegularScreen);
    }
  }
}
