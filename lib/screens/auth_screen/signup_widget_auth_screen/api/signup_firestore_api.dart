import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/custom_user.dart';

enum SignUpStatus { EXIST, NOTEXIST, SUCCESS, ERROR }

class SignUpFirestoreAPI {
  SignUpFirestoreAPI._();

  static Future<SignUpStatus> _alreadyRegistered({
    @required String phone,
  }) async {
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

  static Future<SignUpStatus> signUpCustomUser(UserBuilder userBuilder) async {
    return await _alreadyRegistered(phone: userBuilder.phone);
  }
}
