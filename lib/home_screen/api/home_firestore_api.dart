import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/home_screen/provider/user_notifier.dart';
import 'package:swipe/model/custom_user.dart';

class HomeFirestoreAPI {
  static HomeFirestoreAPI _firestoreAPI;

  HomeFirestoreAPI._() {
    _firestoreAPI = this;
  }

  factory HomeFirestoreAPI() => _firestoreAPI ?? HomeFirestoreAPI._();

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
}
