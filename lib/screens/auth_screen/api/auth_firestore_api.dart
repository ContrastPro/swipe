import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/model/custom_user.dart';

class AuthFirestoreAPI {
  static Future<QuerySnapshot> checkPhoneStatus({String phone}) async {
    return await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();
  }

  static Future<QuerySnapshot> checkEmailStatus({String email}) async {
    return await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
  }

  static Future<void> addUser(CustomUser customUser) {
    CollectionReference users = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users");

    return users
        .add(customUser.toMap())
        .then((value) => print(">> User Added"))
        .catchError((error) => print(">> Failed to add user: $error"));
  }
}
