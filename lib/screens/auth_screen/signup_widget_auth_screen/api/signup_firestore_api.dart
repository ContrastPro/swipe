import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/model/custom_user.dart';

enum SignUpStatus { EXIST, NOTEXIST }

class SignUpFirestoreAPI {
  SignUpFirestoreAPI._();

  static String _verificationId;
  static UserBuilder _userBuilder;

  static String get verificationId => _verificationId;

  static Future<SignUpStatus> alreadyRegistered(String phone) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .where('phone', isEqualTo: phone)
        .limit(1)
        .get();

    if (snapshot.size == 1) {
      return SignUpStatus.EXIST;
    }
    return SignUpStatus.NOTEXIST;
  }

  static codeSentCustomUser({
    UserBuilder userBuilder,
    String verificationId,
  }) {
    _userBuilder = userBuilder;
    _verificationId = verificationId;
  }

  static addCustomUser(String uid) async {
    _userBuilder.uid = uid;
    _userBuilder.createdAt = Timestamp.now();

    await FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Users")
        .doc(uid)
        .set(CustomUser(_userBuilder).toMap());
  }
}
