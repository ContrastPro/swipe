import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/screens/home_screen/provider/user_notifier.dart';

class HomeFirestoreAPI {
  HomeFirestoreAPI._();

  static Future<void> getUserProfile({
    @required UserNotifier userNotifier,
  }) async {
    final User user = AuthFirebaseAPI.getCurrentUser();
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userNotifier.setUserProfile(
        userBuilder: UserBuilder.fromMap(documentSnapshot.data()),
      );
    });
  }

  static Future<UserBuilder> updateUserProfile() async {
    UserBuilder userBuilder;
    final User user = AuthFirebaseAPI.getCurrentUser();
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userBuilder = UserBuilder.fromMap(documentSnapshot.data());
    });
    return userBuilder;
  }
}
