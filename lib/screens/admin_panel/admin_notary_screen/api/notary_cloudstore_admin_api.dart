import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class NotaryCloudstoreAdminAPI {
  NotaryCloudstoreAdminAPI._();

  static Future<String> uploadNotaryImage({
    @required File imageFile,
    @required String photoURL,
    @required String uuid,
  }) async {
    String newPhotoURL;

    if (photoURL != null) {
      // Удаляем старое изображение
      await FirebaseStorage.instance.refFromURL(photoURL).delete();
    }

    Reference newReference =
        FirebaseStorage.instance.ref("Swipe/Notaries/").child("$uuid.jpg");

    await newReference.putFile(imageFile).then((snapshot) async {
      newPhotoURL = await snapshot.ref.getDownloadURL();
    }).catchError((error) => print("Failed to upload image: $error"));

    return newPhotoURL;
  }

  static Future<void> deleteNotaryImage({
    @required String photoURL,
  }) async {
    // Удаляем старое изображение
    await FirebaseStorage.instance.refFromURL(photoURL).delete();
  }
}
