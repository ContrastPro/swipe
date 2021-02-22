import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
import 'package:uuid/uuid.dart';

class ApartmentEditCloudstoreAPI {
  ApartmentEditCloudstoreAPI._();

  static Future<String> uploadApartmentImage({
    @required File imageFile,
  }) async {
    String photoURL;
    final User user = AuthFirebaseAPI.getCurrentUser();

    Reference newReference = FirebaseStorage.instance
        .ref("Swipe/Users/${user.uid}/Ads")
        .child("${Uuid().v1()}.jpeg");

    await newReference.putFile(imageFile).then((snapshot) async {
      photoURL = await snapshot.ref.getDownloadURL();
    }).catchError((error) => print("Failed to upload image: $error"));

    return photoURL;
  }

  static Future<void> deleteApartmentImages({
    @required String imageURL,
  }) async {
    await FirebaseStorage.instance.refFromURL(imageURL).delete();
  }
}
