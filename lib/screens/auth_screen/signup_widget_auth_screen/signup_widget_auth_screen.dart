import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/custom_app_widget/privacy_dialog.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/custom_widget/snackbar_message_auth.dart';
import 'package:swipe/screens/auth_screen/provider/auth_mode_provider.dart';

import 'api/signup_firestore_api.dart';
import 'custom_widget/custom_user_page_signup.dart';
import 'custom_widget/developer_user_page_signup.dart';
import 'custom_widget/first_page_signup.dart';
import 'custom_widget/otp_page_signup.dart';
import 'custom_widget/second_page_signup.dart';

class SignUpWidgetAuthScreen extends StatefulWidget {
  @override
  _SignUpWidgetAuthScreenState createState() => _SignUpWidgetAuthScreenState();
}

class _SignUpWidgetAuthScreenState extends State<SignUpWidgetAuthScreen> {
  final Duration _duration = Duration(milliseconds: 1000);
  final Curve _curve = Curves.easeInOutQuint;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PageController _controller = PageController();

  bool _startLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    _controller.nextPage(
      duration: _duration,
      curve: _curve,
    );
  }

  void _previousPage() {
    _controller.previousPage(
      duration: _duration,
      curve: _curve,
    );
  }

  // Sign Up Developer user
  void _signUpDeveloperUser() {}

  void _enterOTPDeveloperUser({
    @required String smsCode,
  }) {}

  // Sign Up Custom user
  void _signUpCustomUser({
    @required AuthModeNotifier authNotifier,
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
            authNotifier.changeAuthMode();
          },
        );
        break;
      default:
        await FirebaseAuth.instance.verifyPhoneNumber(
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
            SignUpFirestoreAPI.codeSentCustomUser(
              userBuilder: userBuilder,
              verificationId: verificationId,
            );
            setState(() => _startLoading = false);
            PrivacyDialog.showPrivacyDialog(
              context: context,
              onPressed: () => _nextPage(),
            );
          },
        );
        break;
    }
  }

  void _enterOTPCustomUser({
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

  Widget _buildScreen(AuthModeNotifier authNotifier) {
    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            /*FirstPageSignUp(
              onTap: () => _nextPage(),
            ),
            SecondPageSignUp(
              onDeveloperUserTap: () {
                _controller.jumpToPage(2);
              },
              onCustomUserTap: () {
                _controller.jumpToPage(4);
              },
            ),
            // Developer User Pages
            DeveloperUserPageSignUp(),
            OTPPageSignUp(
              onSubmit: (String otp) {},
            ),*/

            // Custom User Pages
            CustomUserPageSignUp(
              onSubmit: (UserBuilder userBuilder) {
                _signUpCustomUser(
                  authNotifier: authNotifier,
                  userBuilder: userBuilder,
                );
              },
            ),
            OTPPageSignUp(
              onCompleted: (String smsCode) {
                _enterOTPCustomUser(smsCode: smsCode);
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
    return Consumer<AuthModeNotifier>(
      builder: (context, authNotifier, child) {
        return WillPopScope(
          onWillPop: () async {
            switch (_controller.page.toInt()) {
              case 0:
                authNotifier.changeAuthMode();
                return false;
              case 1:
                _previousPage();
                return false;
              default:
                return false;
            }
          },
          child: _buildScreen(authNotifier),
        );
      },
    );
  }
}
