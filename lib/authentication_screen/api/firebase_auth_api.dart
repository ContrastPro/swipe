import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/authentication_screen/api/auth_firebase_firestore_api.dart';

enum AuthStatus { EXIST, NOTEXIST, SUCCESS, ERROR }

class AuthAPI {
  String _verificationId;
  String _message;
  AuthStatus _status;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String get message => _message;

  AuthStatus get status => _status;

  String _autoEditPhoneNumber(String phone) {
    String splitPhone = phone.split(" ").join("");
    if (splitPhone.contains("+")) {
      return splitPhone;
    } else {
      return "+$splitPhone";
    }
  }

  Future<void> verifyPhoneNumber({String phone}) async {
    String splitPhone = _autoEditPhoneNumber(phone);
    print(splitPhone);
    if (splitPhone != null && splitPhone != "") {
      final QuerySnapshot result =
          await AuthFirebaseFirestore.checkUserStatus(phone: splitPhone);

      if (result.docs.length == 1) {
        _status = AuthStatus.EXIST;
        print('Document data EXIST');
        _firebaseAuth.setLanguageCode("ru");

        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: splitPhone,
          codeSent: (String verificationId, int resendToken) {
            _verificationId = verificationId;
            print(">> Code sent: $verificationId, $resendToken");
          },
          verificationCompleted: (PhoneAuthCredential credential) {
            print(">> Auto Verification COMPLETED");
          },
          verificationFailed: (FirebaseAuthException exception) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } else {
        _status = AuthStatus.NOTEXIST;
        _message = 'Аккаунта с таким номером телефона ещё не существует.';
        print('Document data NOT EXIST');
      }
    } else {
      _status = AuthStatus.ERROR;
      _message = 'Похоже ваш номер неверного формата';
    }
  }

  Future<void> signInWithPhoneNumber({String smsCode}) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );

    try {
      await _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((value) async {
        if (value.user != null) {
          print(">> SIGH IN SUCCESSFULLY");
        }
      });

      _status = AuthStatus.SUCCESS;
    } catch (e) {
      print(">>> SIGH IN FAILED: ${e.message}");
      _message = "Похоже вы ввели неверный код. Попробуйте снова";
      _status = AuthStatus.ERROR;
    }
  }

  static User getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
