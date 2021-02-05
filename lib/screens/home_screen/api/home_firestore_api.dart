import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

class HomeFirestoreAPI {
  static Future<UserBuilder> getUserProfile() async {
    final User user = AuthFirebaseAPI.getCurrentUser();
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .where('uid', isEqualTo: user.uid)
        .limit(1)
        .get();

    List<UserBuilder> userProfileList = List<UserBuilder>();

    querySnapshot.docs.forEach((element) {
      UserBuilder userBuilder = UserBuilder.fromMap(element.data());
      userProfileList.add(userBuilder);
    });
    return userProfileList[0];
  }

  static Future<void> editUserProfile(CustomUser customUser) {
    CollectionReference users = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users");

    return users
        .add(customUser.toMap())
        .then((value) => print(">> User Info Modified"))
        .catchError((error) => print(">> Failed to modified user info: $error"));
  }
}
