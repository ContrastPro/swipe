import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

class EditProfileFirestoreAPI {
  EditProfileFirestoreAPI._();

  static Future<void> editUserProfile({CustomUser customUser}) {
    final User user = AuthFirebaseAPI.getCurrentUser();
    final DocumentReference users = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(user.uid);

    return users
        .update(customUser.toMap())
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
