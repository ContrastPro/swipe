import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationAPI {
  String _verificationId;
  String _errorCode;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<void> verifyPhoneNumber({String phone}) async {
    _firebaseAuth.setLanguageCode("ru");
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        print(">> Verification COMPLETED");
      },
      verificationFailed: (FirebaseAuthException exception) {
        _errorCode = exception.message;
        print(">> Verification FAILED: ${exception.message}");
      },
      codeSent: (String verificationId, int resendToken) {
        _verificationId = verificationId;
        print(">> Code sent: $verificationId, $resendToken");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<bool> enterOTPCode({String smsCode}) async {
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

      return true;
    } catch (e) {
      _errorCode = e.message.toString();
      print(">> Verification FAILED: ${e.message}");
      return false;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
