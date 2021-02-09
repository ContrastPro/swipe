import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/model/custom_user.dart';

class AuthFirestoreAPI {
  AuthFirestoreAPI._();

  static Future<QuerySnapshot> checkPhoneStatus({String phone}) async {
    return await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();
  }

  static Future<void> addUser({CustomUser customUser, User user}) {
    final CollectionReference users = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users");

    return users
        .doc(user.uid)
        .set(customUser.toMap())
        .then((value) => print(">> User Added"))
        .catchError((error) => print(">> Failed to add user: $error"));
  }
}
