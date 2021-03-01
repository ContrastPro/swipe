import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/home_screen/api/home_firestore_api.dart';

class UserNotifier with ChangeNotifier {
  bool _accessIsAllowed;
  UserBuilder _userBuilder;

  bool get accessIsAllowed => _accessIsAllowed;

  UserBuilder get userProfile => _userBuilder;

  void setUserProfile({@required UserBuilder userBuilder}) async {
    _userBuilder = userBuilder;
    log("$_userBuilder");
    notifyListeners();
  }

  void updateUserProfile() async {
    _userBuilder = await HomeFirestoreAPI.updateUserProfile();
    log("$_userBuilder");
    notifyListeners();
  }

  void setAccess(bool access){
    _accessIsAllowed = access;
    notifyListeners();
  }
}
