import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/screens/auth_screen/custom_widget/snackbar_message_auth.dart';
import 'package:swipe/screens/auth_screen/provider/auth_mode_provider.dart';
import 'package:swipe/screens/auth_screen/signin_widget_auth_screen/custom_widget/second_page_signin.dart';

import 'api/signin_firestore_api.dart';
import 'custom_widget/first_page_signin.dart';
import 'custom_widget/otp_page_signin.dart';

class SignInWidgetAuthScreen extends StatefulWidget {
  final AuthModeNotifier authNotifier;

  const SignInWidgetAuthScreen({
    Key key,
    @required this.authNotifier,
  }) : super(key: key);

  @override
  _SignInWidgetAuthScreenState createState() => _SignInWidgetAuthScreenState();
}

class _SignInWidgetAuthScreenState extends State<SignInWidgetAuthScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PageController _controller = PageController(keepPage: false);

  bool _startLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    _controller.nextPage(
      duration: widget.authNotifier.duration,
      curve: widget.authNotifier.curve,
    );
  }

  void _previousPage() {
    _controller.previousPage(
      duration: widget.authNotifier.duration,
      curve: widget.authNotifier.curve,
    );
  }

  void _verifyPhoneUser(String phone) async {
    setState(() => _startLoading = true);
    await _firebaseAuth.setLanguageCode("ru");
    switch (await SignInFirestoreAPI.alreadyRegistered(phone)) {
      case SignInStatus.EXIST:
        _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
          verificationFailed: (FirebaseAuthException e) {
            setState(() => _startLoading = false);
            SnackBarMessageAuth.showSnackBar(
              context: context,
              content: "Указаный вами номер неверного формата.",
            );
          },
          codeSent: (String verificationId, int resendToken) {
            setState(() => _startLoading = false);
            SignInFirestoreAPI.codeSentUser(
              verificationId: verificationId,
            );
            _nextPage();
          },
        );
        break;
      default:
        setState(() => _startLoading = false);
        SnackBarMessageAuth.showSnackBar(
          context: context,
          content: "Номер телефона не зарегистрирован.",
          action: "Регистрация",
          onPressed: () {
            widget.authNotifier.changeAuthMode();
          },
        );
    }
  }

  void _signInUser({
    @required String smsCode,
  }) async {
    setState(() => _startLoading = true);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: SignInFirestoreAPI.verificationId,
      smsCode: smsCode,
    );

    try {
      await _firebaseAuth.signInWithCredential(
        phoneAuthCredential,
      );
    } catch (e) {
      setState(() => _startLoading = false);
      SnackBarMessageAuth.showSnackBar(
        context: context,
        content: "Вы ввели неверный код.",
      );
    }
  }

  Widget _buildScreen() {
    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            FirstPageSignIn(
              onTap: () => _nextPage(),
            ),
            SecondPageSignIn(
              onCompleted: (String phone) {
                _verifyPhoneUser(phone);
              },
            ),
            OTPPageSignIn(
              onCompleted: (String smsCode) {
                _signInUser(smsCode: smsCode);
              },
            ),
          ],
        ),
        if (_startLoading == true) WaveIndicator(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        switch (_controller.page.toInt()) {
          case 0:
            return true;
          default:
            _previousPage();
            return false;
        }
      },
      child: _buildScreen(),
    );
  }
}
