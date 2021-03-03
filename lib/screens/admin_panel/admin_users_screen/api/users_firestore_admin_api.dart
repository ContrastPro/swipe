import 'package:cloud_firestore/cloud_firestore.dart';

class UsersFirestoreAdminApi {
  UsersFirestoreAdminApi._();

  static Stream<QuerySnapshot> getUsers() {
    return FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }
}
