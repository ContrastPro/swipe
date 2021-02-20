import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/custom_user.dart';

class ApartmentFirestoreAPI {
  ApartmentFirestoreAPI._();

  static Future<UserBuilder> getOwnerProfile({
    @required String ownerUID,
  }) async {
    UserBuilder userBuilder;

    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(ownerUID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userBuilder = UserBuilder.fromMap(documentSnapshot.data());
    });
    return userBuilder;
  }
}
