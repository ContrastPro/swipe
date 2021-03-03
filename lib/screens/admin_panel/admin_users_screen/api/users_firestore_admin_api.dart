import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersFirestoreAdminApi {
  UsersFirestoreAdminApi._();

  static Stream<QuerySnapshot> getUsers() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  static Future<void> blockUser({
    @required String uid,
  }) async {
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(uid)
        .update({
      "isBanned": true,
    });
  }

  static Future<void> unblockUser({
    @required String uid,
  }) async {
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(uid)
        .update({
      "isBanned": false,
    });
  }
}
