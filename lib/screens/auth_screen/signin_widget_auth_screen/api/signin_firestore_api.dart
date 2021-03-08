import 'package:cloud_firestore/cloud_firestore.dart';

enum SignInStatus { EXIST, NOTEXIST }

class SignInFirestoreAPI {
  SignInFirestoreAPI._();

  static String _verificationId;

  static String get verificationId => _verificationId;

  static Future<SignInStatus> alreadyRegistered(String phone) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();

    if (snapshot.size == 1) {
      return SignInStatus.EXIST;
    }
    return SignInStatus.NOTEXIST;
  }

  static void codeSentUser({String verificationId}) {
    _verificationId = verificationId;
  }
}
