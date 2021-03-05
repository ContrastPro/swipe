import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:swipe/model/custom_user.dart';

class UserNotifier with ChangeNotifier {
  UserBuilder _userBuilder;

  UserBuilder get userProfile => _userBuilder;

  void setUserProfile({@required UserBuilder userBuilder}) {
    _userBuilder = userBuilder;
    log("$_userBuilder", name: "User Profile");
    notifyListeners();
  }
}