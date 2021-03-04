import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'users_cloudstore_admin_api.dart';

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
    // Блокируем пользователя
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(uid)
        .update({
      "isBanned": true,
      "accessIsAllowed": false,
    }).then((value) async {
      // Удаляем все объявления пользователя
      await FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Ads")
          .where("ownerUID", isEqualTo: uid)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((doc) async {
          // Удаляем все фото в объявлении
          List<String> images = List<String>.from(doc["images"]);
          await Future.wait(images.map((imageURL) {
            return UsersCloudstoreAdminApi.deleteUserAdsImages(
              imageURL: imageURL,
            );
          }));
          // Удаляем объявление
          await doc.reference.delete();
        });
      });
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
