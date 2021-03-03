import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/home_screen/provider/user_provider.dart';

class HomeFirestoreAPI {
  HomeFirestoreAPI._();

  static Stream<UserBuilder> streamUser({
    @required UserNotifier userNotifier,
    @required String userUID,
  }) {
    UserBuilder userBuilder;

    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(userUID)
        .snapshots()
        .map((DocumentSnapshot document) {
      userBuilder = UserBuilder.fromMap(document.data());
      userNotifier.setUserProfile(userBuilder: userBuilder);
      return userBuilder;
    });
  }

  static Stream<QuerySnapshot> streamAds() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Ads")
        .orderBy("promotion.adWeight", descending: true)
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  static void getAccess({
    @required UserBuilder userBuilder,
  }) async {
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(userBuilder.uid)
        .update({
      "accessIsAllowed": false,
    });
  }
}
