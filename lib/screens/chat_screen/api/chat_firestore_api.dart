import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
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
    @required String ownerUID,
    @required String message,
  }) async {
    final String key = Uuid().v1();
    final Timestamp timestamp = Timestamp.now();

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
    await referenceUser.set({
      "ownerUID": _user.uid,
      "message": message,
      "createAt": timestamp,
    }).then((value) {
      // Обновляем информацию чата
      FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(_user.uid)
          .collection("Chats")
          .doc(ownerUID)
          .set({
        "lastActivity": timestamp,
      });
    });

    // Отправляем сообщение собеседнику
    await referenceOwner.set({
      "ownerUID": _user.uid,
      "message": message,
      "createAt": timestamp,
    }).then((value) {
      // Обновляем информацию чата
      FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(ownerUID)
          .collection("Chats")
          .doc(_user.uid)
          .set({
        "lastActivity": timestamp,
      });
    });
  }

  static Future<void> deleteFromMe({
    @required String ownerUID,
    @required String documentID,
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
  }

  static Future<void> deleteEverywhere({
    @required String ownerUID,
    @required String documentID,
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
  }
}
