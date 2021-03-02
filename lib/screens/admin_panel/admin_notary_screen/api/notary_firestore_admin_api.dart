import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/notary.dart';
import 'package:uuid/uuid.dart';

class NotaryFirestoreAdminApi {
  NotaryFirestoreAdminApi._();

  static Stream<QuerySnapshot> getNotary() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .snapshots();
  }

  static Future<void> addNotary({
    @required NotaryBuilder notaryBuilder,
  }) async {
    final String uuid = Uuid().v1();

    notaryBuilder.id = uuid;
    notaryBuilder.createAt = Timestamp.now();

    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .doc(uuid)
        .set(Notary(notaryBuilder).toMap());
  }

  static Future<void> editNotary({
    @required NotaryBuilder notaryBuilder,
  }) async {
    notaryBuilder.updateAt = Timestamp.now();

    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .doc(notaryBuilder.id)
        .update(Notary(notaryBuilder).toMap());
  }
}
