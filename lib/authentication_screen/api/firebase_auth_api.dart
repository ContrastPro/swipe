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

  Future<void> verifyPhoneNumber({String phone}) async {
    if (phone.contains("+") && phone != null && phone != "") {
      final QuerySnapshot result =
          await AuthFirebaseFirestore.checkUserStatus(phone: phone);

      if (result.docs.length == 1) {
        _status = AuthStatus.EXIST;
        print('Document data EXIST');
        _firebaseAuth.setLanguageCode("ru");

        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) {
            print(">> Auto Verification COMPLETED");
          },
          verificationFailed: (FirebaseAuthException exception) {
            /*_message = 'Похоже ваш номер неверного формата';
              _status = AuthStatus.ERROR; */
            print(">> Verification FAILED: ${exception.message}");
          },
          codeSent: (String verificationId, int resendToken) {
            _verificationId = verificationId;
            print(">> Code sent: $verificationId, $resendToken");
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } else {
        _status = AuthStatus.NOTEXIST;
        _message = 'Аккаунта с таким номером телефона ещё не существует.';
        print('Document data NOT EXIST');
      }
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
      _message = "Похоже вы ввели неверный код";
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
