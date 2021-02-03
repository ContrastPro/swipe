import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/auth_screen/api/auth_firestore_api.dart';

enum AuthStatus { EXIST, NOTEXIST, SUCCESS, ERROR }

class AuthFirebaseAPI {
  AuthStatus _status;
  String _message;
  String _verificationId;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static AuthFirebaseAPI _authFirebaseAPI;

  AuthStatus get status => _status;

  String get message => _message;

  AuthFirebaseAPI._() {
    _authFirebaseAPI = this;
  }

  factory AuthFirebaseAPI() => _authFirebaseAPI ?? AuthFirebaseAPI._();

  Future<void> signInWithPhoneNumber({String phone}) async {
    final QuerySnapshot result =
        await AuthFirestoreAPI.checkUserStatus(phone: phone);

    if (result.docs.length == 1) {
      _status = AuthStatus.EXIST;
      print('Document data EXIST');
      _firebaseAuth.setLanguageCode("ru");

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
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
  }

  Future<void> signUpWithPhoneNumber({String phone}) async {
    final QuerySnapshot result =
    await AuthFirestoreAPI.checkUserStatus(phone: phone);

    if (result.docs.length == 1) {
      _status = AuthStatus.EXIST;
      _message = 'Аккаунт с таким номером телефона уже существует.';
      print('Document data EXIST');
    } else {
      _status = AuthStatus.NOTEXIST;
      print('Document data NOT EXIST');
      _firebaseAuth.setLanguageCode("ru");

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (String verificationId, int resendToken) {
          _verificationId = verificationId;
          print(">> Code sent: $verificationId, $resendToken");
        },
        verificationCompleted: (PhoneAuthCredential credential) {
          print(">> Auto Verification COMPLETED");
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(">>> ERROR ${exception.message}");
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  Future<void> enterWithCredential({String smsCode}) async {
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
