import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/notary.dart';
import 'package:uuid/uuid.dart';

import 'notary_cloudstore_admin_api.dart';

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
    @required File imageFile,
  }) async {
    final String uuid = Uuid().v1();

    if (imageFile != null) {
      notaryBuilder.photoURL = await NotaryCloudstoreAdminAPI.uploadNotaryImage(
        imageFile: imageFile,
        photoURL: notaryBuilder.photoURL,
        uuid: uuid,
      );
    }

    notaryBuilder.id = uuid;
    notaryBuilder.createdAt = Timestamp.now();

    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .doc(uuid)
        .set(Notary(notaryBuilder).toMap());
  }

  static Future<void> editNotary({
    @required NotaryBuilder notaryBuilder,
    @required File imageFile,
  }) async {
    if (imageFile != null) {
      notaryBuilder.photoURL = await NotaryCloudstoreAdminAPI.uploadNotaryImage(
        imageFile: imageFile,
        photoURL: notaryBuilder.photoURL,
        uuid: notaryBuilder.id,
      );
    }
    notaryBuilder.updatedAt = Timestamp.now();

    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .doc(notaryBuilder.id)
        .update(Notary(notaryBuilder).toMap());
  }

  static Future<void> deleteNotary({
    @required NotaryBuilder notaryBuilder,
  }) async {
    if (notaryBuilder.photoURL != null) {
      await NotaryCloudstoreAdminAPI.deleteNotaryImage(
        photoURL: notaryBuilder.photoURL,
      );
    }
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .doc(notaryBuilder.id)
        .delete();
  }
}
