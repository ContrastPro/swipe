import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UsersCloudstoreAdminApi{
  UsersCloudstoreAdminApi._();

  static Future<void> deleteUserAdsImages({
    @required String imageURL,
  }) async {
    await FirebaseStorage.instance.refFromURL(imageURL).delete();
  }
}