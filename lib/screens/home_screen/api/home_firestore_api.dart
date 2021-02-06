import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

class HomeFirestoreAPI {
  static Future<UserBuilder> getUserProfile() async {
    UserBuilder userBuilder;
    final User user = AuthFirebaseAPI.getCurrentUser();
    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userBuilder = UserBuilder.fromMap(documentSnapshot.data());
    });
    return userBuilder;
  }
}
