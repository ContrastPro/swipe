import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

import 'edit_profile_cloudstore_api.dart';

class EditProfileFirestoreAPI {
  EditProfileFirestoreAPI._();

  static Future<void> editUserProfile({
    @required UserBuilder userBuilder,
    @required File imageFile,
  }) async {
    final User user = AuthFirebaseAPI.getCurrentUser();
    if (imageFile != null) {
      // Загрузить/Обновить изображение и вернуть ссылку
      userBuilder.photoURL = await EditProfileCloudstoreAPI.uploadProfileImage(
        imageFile: imageFile,
        photoURL: userBuilder.photoURL,
      );
    }

    userBuilder.updatedAt = Timestamp.now();

    final DocumentReference users = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(user.uid);

    return users
        .update(CustomUser(userBuilder: userBuilder).toMap())
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
