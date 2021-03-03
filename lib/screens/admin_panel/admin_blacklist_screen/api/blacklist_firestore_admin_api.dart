import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlacklistFirestoreAdminApi {
  BlacklistFirestoreAdminApi._();

  static Stream<QuerySnapshot> getBlacklist() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .where("isBanned", isEqualTo: true)
        .snapshots();
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
