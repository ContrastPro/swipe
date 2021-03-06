import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/custom_app_widget/privacy_dialog.dart';
import 'package:swipe/model/building.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/custom_widget/snackbar_message_auth.dart';
import 'package:swipe/screens/auth_screen/provider/auth_mode_provider.dart';

import 'api/signup_firestore_api.dart';
import 'custom_widget/custom_user_page_signup.dart';
import 'custom_widget/first_page_signup.dart';
import 'custom_widget/otp_page_signup.dart';
import 'custom_widget/second_page_signup.dart';

class SignUpWidgetAuthScreen extends StatefulWidget {
  final AuthModeNotifier authNotifier;

  const SignUpWidgetAuthScreen({
    Key key,
    @required this.authNotifier,
  }) : super(key: key);

  @override
  _SignUpWidgetAuthScreenState createState() => _SignUpWidgetAuthScreenState();
}

class _SignUpWidgetAuthScreenState extends State<SignUpWidgetAuthScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PageController _controller = PageController(keepPage: false);

  BuildingBuilder _buildingBuilder;
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

  void _verifyPhoneNumber({
    @required UserBuilder userBuilder,
  }) async {
    setState(() => _startLoading = true);
    await _firebaseAuth.setLanguageCode("ru");
    switch (await SignUpFirestoreAPI.alreadyRegistered(userBuilder.phone)) {
      case SignUpStatus.EXIST:
        setState(() => _startLoading = false);
        SnackBarMessageAuth.showSnackBar(
          context: context,
          content: "Аккаунт с таким номером телефона уже существует.",
          action: "Войти",
          onPressed: () {
            widget.authNotifier.changeAuthMode();
          },
        );
        break;
      default:
        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: userBuilder.phone,
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
            userBuilder.buildingBuilder = _buildingBuilder;
            SignUpFirestoreAPI.codeSentCustomUser(
              userBuilder: userBuilder,
              verificationId: verificationId,
            );
            PrivacyDialog.showPrivacyDialog(
              context: context,
              onPressed: () => _nextPage(),
            );
            log("$userBuilder");
          },
        );
        break;
    }
  }

  void _signInWithCredential({
    @required String smsCode,
  }) async {
    setState(() => _startLoading = true);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: SignUpFirestoreAPI.verificationId,
      smsCode: smsCode,
    );

    try {
      await _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((value) async {
        if (value.user != null) {
          await SignUpFirestoreAPI.addCustomUser(
            value.user.uid,
          );
        }
      });
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
            FirstPageSignUp(
              onTap: () => _nextPage(),
            ),
            SecondPageSignUp(
              onDeveloperUserTap: () {
                _buildingBuilder = BuildingBuilder();
                _nextPage();
              },
              onCustomUserTap: () {
                _buildingBuilder = null;
                _nextPage();
              },
            ),
            CustomUserPageSignUp(
              onSubmit: (UserBuilder userBuilder) {
                _verifyPhoneNumber(
                  userBuilder: userBuilder,
                );
              },
            ),
            OTPPageSignUp(
              onCompleted: (String smsCode) {
                _signInWithCredential(smsCode: smsCode);
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
            widget.authNotifier.changeAuthMode();
            return false;
          default:
            _previousPage();
            return false;
        }
      },
      child: _buildScreen(),
    );
  }
}
