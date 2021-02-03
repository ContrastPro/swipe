import 'package:cloud_firestore/cloud_firestore.dart';

class AuthFirestoreAPI {
  static AuthFirestoreAPI _firestoreAPI;

  AuthFirestoreAPI._() {
    _firestoreAPI = this;
  }

  factory AuthFirestoreAPI() => _firestoreAPI ?? AuthFirestoreAPI._();

  static Future<QuerySnapshot> checkUserStatus({String phone}) async {
    return await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();
  }
}
