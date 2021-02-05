import 'package:flutter/foundation.dart';
import 'package:swipe/home_screen/api/home_firestore_api.dart';
import 'package:swipe/model/custom_user.dart';

class UserNotifier with ChangeNotifier {
  UserBuilder _userBuilder;

  UserBuilder get userProfile => _userBuilder;

  void setUserProfile() async {
    _userBuilder = await HomeFirestoreAPI.getUserProfile();
    print(_userBuilder);
    notifyListeners();
  }
}
