import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

class FeedbackFirestoreAPI {
  static Stream<QuerySnapshot> getChats() {
    final User user = AuthFirebaseAPI.getCurrentUser();
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(user.uid)
        .collection("Chats")
        .snapshots();
  }
}
