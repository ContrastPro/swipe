import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/screens/home_screen/provider/user_provider.dart';

class HomeFirestoreAPI {
  HomeFirestoreAPI._();

  static User user = AuthFirebaseAPI.getCurrentUser();

  static Future<void> getUserInfo({
    @required UserNotifier userNotifier,
  }) async {
    // Загружаем профиль пользователя
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

    // Проверяем есть ли доступ к админке
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Admins")
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userNotifier.setAccess(documentSnapshot["accessIsAllowed"]);
      } else {
        userNotifier.setAccess(null);
      }
    });
  }

  static Future<UserBuilder> updateUserProfile() async {
    UserBuilder userBuilder;
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

  static Stream<QuerySnapshot> getAds() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Ads")
        .orderBy("promotion.adWeight", descending: true)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  static void getAccess({
    @required UserNotifier userNotifier,
    @required UserBuilder userBuilder,
  }) async {
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Admins")
        .doc(userBuilder.uid)
        .set({
      "uid": userBuilder.uid,
      "accessIsAllowed": false,
    }).then((value) {
      userNotifier.setAccess(false);
    });
  }
}
