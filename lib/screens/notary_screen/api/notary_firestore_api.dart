import 'package:cloud_firestore/cloud_firestore.dart';

class NotaryFirestoreAPI {
  NotaryFirestoreAPI._();

  static Stream<QuerySnapshot> getNotary() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Notaries")
        .snapshots();
  }
}
