import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/message.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/screens/chat_screen/api/chat_cloudstore_api.dart';
import 'package:uuid/uuid.dart';

class ChatFirestoreAPI {
  static User _user = AuthFirebaseAPI.getCurrentUser();

  static Stream<QuerySnapshot> getChat({
    @required String ownerUID,
  }) {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(_user.uid)
        .collection("Chats")
        .doc(ownerUID)
        .collection("Chat")
        .orderBy('createAt', descending: true)
        .snapshots();
  }

  static Future<void> sendMassage({
    @required File imageFile,
    @required String ownerUID,
    @required MessageBuilder messageBuilder,
  }) async {
    final String key = Uuid().v1();
    messageBuilder.ownerUID = _user.uid;
    messageBuilder.createAt = Timestamp.now();

    if (imageFile != null) {
      messageBuilder.attachFile = "loading";
    }

    final Message message = Message(messageBuilder);

    final DocumentReference referenceUser = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(_user.uid)
        .collection("Chats")
        .doc(ownerUID)
        .collection("Chat")
        .doc(key);

    final DocumentReference referenceOwner = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(ownerUID)
        .collection("Chats")
        .doc(_user.uid)
        .collection("Chat")
        .doc(key);

    // Отправляем сообщение себе
    await referenceUser.set(message.toMap()).then((value) async {
      // Публикуем изображение для себя
      if (imageFile != null) {
        String image = await ChatCloudstoreAPI.uploadChatImage(
          userUID: _user.uid,
          imageFile: imageFile,
        );

        await referenceUser.update({
          "attachFile": image,
        });
      }

      // Обновляем информацию чата
      await FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(_user.uid)
          .collection("Chats")
          .doc(ownerUID)
          .set({
        "lastActivity": message.createAt,
      });
    });

    // Отправляем сообщение собеседнику
    await referenceOwner.set(message.toMap()).then((value) async {
      if (imageFile != null) {
        // Публикуем изображение для собеседника
        if (imageFile != null) {
          String image = await ChatCloudstoreAPI.uploadChatImage(
            userUID: ownerUID,
            imageFile: imageFile,
          );

          await referenceOwner.update({
            "attachFile": image,
          });
        }
      }
      // Обновляем информацию чата
      await FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(ownerUID)
          .collection("Chats")
          .doc(_user.uid)
          .set({
        "lastActivity": message.createAt,
      });
    });
    log("$messageBuilder");
  }

  static Future<void> deleteFromMe({
    @required String ownerUID,
    @required String documentID,
    @required String attachFile,
  }) async {
    // Удаляем сообщение у себя
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(_user.uid)
        .collection("Chats")
        .doc(ownerUID)
        .collection("Chat")
        .doc(documentID)
        .delete();

    if (attachFile != null) {
      await ChatCloudstoreAPI.deleteChatImage(
        attachFile: attachFile,
      );
    }
  }

  static Future<void> deleteEverywhere({
    @required String ownerUID,
    @required String documentID,
    @required String attachFile,
  }) async {
    // Удаляем сообщение у себя
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(_user.uid)
        .collection("Chats")
        .doc(ownerUID)
        .collection("Chat")
        .doc(documentID)
        .delete();

    if (attachFile != null) {
      // Удаляем изображение у себя
      await ChatCloudstoreAPI.deleteChatImage(attachFile: attachFile);

      // Удаляем изображение у собеседника
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(ownerUID)
          .collection("Chats")
          .doc(_user.uid)
          .collection("Chat")
          .doc(documentID)
          .get();

      if (documentSnapshot.exists) {
        await ChatCloudstoreAPI.deleteChatImage(
          attachFile: documentSnapshot["attachFile"],
        );
      }

      // Удаляем сообщение у собеседника
      await FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(ownerUID)
          .collection("Chats")
          .doc(_user.uid)
          .collection("Chat")
          .doc(documentID)
          .delete();
    } else {
      await FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(ownerUID)
          .collection("Chats")
          .doc(_user.uid)
          .collection("Chat")
          .doc(documentID)
          .delete();
    }
  }
}
