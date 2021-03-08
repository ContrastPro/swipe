import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/global/firebase_api.dart';

class FeedbackFirestoreAPI {
  FeedbackFirestoreAPI._();

  static Stream<QuerySnapshot> getChats() {
    final User user = FirebaseAPI.currentUser();
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(user.uid)
        .collection("Chats")
        .orderBy('lastActivity', descending: true)
        .snapshots();
  }
}
