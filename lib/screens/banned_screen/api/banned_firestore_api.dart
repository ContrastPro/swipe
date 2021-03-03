import 'package:cloud_firestore/cloud_firestore.dart';

class BannedFirestoreApi{
  BannedFirestoreApi._();

  static Stream isBannedStream(String userUID){
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(userUID)
        .snapshots();
  }
}