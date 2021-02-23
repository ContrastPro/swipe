import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

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
    final CollectionReference referenceUser = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(_user.uid)
        .collection("Chats")
        .doc(ownerUID)
        .collection("Chat");

    final CollectionReference referenceOwner = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(ownerUID)
        .collection("Chats")
        .doc(_user.uid)
        .collection("Chat");

    Timestamp timestamp = Timestamp.now();

    // Отправляем сообщение себе
    await referenceUser.add({
      "ownerUID": _user.uid,
      "message": message,
      "createAt": timestamp,
    }).then((DocumentReference document) {
      // Обновляем информацию чата
      FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(_user.uid)
          .collection("Chats")
          .doc(ownerUID)
          .set({
        "lastMessage": message,
        "lastActivity": timestamp,
      });
    });

    // Отправляем сообщение собеседнику
    await referenceOwner.add({
      "ownerUID": _user.uid,
      "message": message,
      "createAt": timestamp,
    }).then((DocumentReference document) {
      // Обновляем информацию чата
      FirebaseFirestore.instance
          .collection("Swipe")
          .doc("Database")
          .collection("Users")
          .doc(ownerUID)
          .collection("Chats")
          .doc(_user.uid)
          .set({
        "lastMessage": message,
        "lastActivity": timestamp,
      });
    });
  }
}
