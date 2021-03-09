import 'dart:developer';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatCloudstoreAPI {
  ChatCloudstoreAPI._();

  static Future<String> uploadChatImage({
    @required String userUID,
    @required File imageFile,
  }) async {
    String photoURL;

    Reference newReference = FirebaseStorage.instance
        .ref("Swipe/Users/$userUID/Chats")
        .child("${Uuid().v1()}.jpeg");

    await newReference.putFile(imageFile).then((snapshot) async {
      photoURL = await snapshot.ref.getDownloadURL();
    }).catchError((error) => print("Failed to upload image: $error"));

    return photoURL;
  }

  static Future<void> deleteChatImage({
    @required String attachFile,
  }) async {
    Reference oldReference = FirebaseStorage.instance.refFromURL(attachFile);
    await oldReference.delete().then((value) {
      log("Image Deleted");
    });
  }
}
