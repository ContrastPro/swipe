import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/screens/auth_screen/custom_widget/expandeble_page_view.dart';
import 'package:swipe/screens/auth_screen/custom_widget/gradient_text_field.dart';
import 'package:swipe/screens/auth_screen/custom_widget/one_time_password_widget.dart';
import 'package:swipe/screens/auth_screen/custom_widget/switch_auth_widget.dart';
import 'package:swipe/screens/auth_screen/provider/auth_signup_provider.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/custom_app_widget/notification_dialog.dart';
import 'package:swipe/custom_app_widget/privacy_dialog.dart';
import 'package:swipe/model/custom_user.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  int _pageIndex = 0;
  bool _showHelp = false;
  AuthSignUpNotifier _signUpNotifier;
  UserBuilder _userBuilder;

  EdgeInsets _itemPadding;
  PageController _pageController;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _userBuilder = UserBuilder();
    _itemPadding = const EdgeInsets.symmetric(horizontal: 45.0);
    _pageController = PageController(initialPage: 0, keepPage: true);
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage() {
    setState(() => _pageIndex++);
    _pageController.animateToPage(
      _pageIndex,
      duration: Duration(milliseconds: 800),
      curve: Curves.ease,
    );
  }

  void _showInfoDialog(String content) {
    showDialog(
      context: context,
      builder: (context) {
        return NotificationDialog(
          title: 'Упс...',
          content: content,
        );
      },
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PrivacyDialog(
          onPressed: () => _changePage(),
        );
      },
    );
  }

  Future<void> _startSignUp() async {
    _signUpNotifier.userBuilder = _userBuilder;
    String splitPhone = await _signUpNotifier.signUpWithPhoneNumber(
      context: context,
    );
    print(splitPhone);
    if (_signUpNotifier.phoneIsNotExist() == true) {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: splitPhone,
          codeSent: (String verificationId, int resendToken) {
            _signUpNotifier.setVerificationId = verificationId;
            _showPrivacyDialog();
          },
          verificationFailed: (FirebaseAuthException exception) {
            if (exception.code == 'invalid-phone-number') {
              _showInfoDialog("Указаный вами телефон неверного формата");
            } else {
              _showInfoDialog(exception.message);
            }
          },
          verificationCompleted: (PhoneAuthCredential credential) {},
          codeAutoRetrievalTimeout: (String verId) {},
        );
      } catch (e) {}
    } else {
      setState(() => _showHelp = true);
    }
  }

  Widget _buildTextInfo({String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFirstPage() {
    return Padding(
      padding: _itemPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTextInfo(
            title:
                "Пройди регистрацию, чтобы открыть доступ к самой полной базе "
                "рынка квартир в Сочи!",
          ),
          SizedBox(height: 55.0),
          GradientButton(
            title: "Регистрация",
            maxWidth: 280.0,
            minHeight: 50.0,
            borderRadius: 10.0,
            onTap: () => _changePage(),
          ),
          SizedBox(height: 20.0),
          SwitchAuthWidget(),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    double boxHeight = 14.0;
    double fieldWidth = 280.0;
    double fieldHeight = 50.0;
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: _itemPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientTextField(
              width: fieldWidth,
              height: fieldHeight,
              hintText: "Имя",
              keyboardType: TextInputType.name,
              onChanged: (String value) {
                _userBuilder.name = value;
              },
              formatter: [
                FilteringTextInputFormatter.deny(RegExp(' ')),
              ],
              validator: (String value) {
                if (value.isEmpty) return '';
                return null;
              },
            ),
            SizedBox(height: boxHeight),
            GradientTextField(
              width: fieldWidth,
              height: fieldHeight,
              hintText: "Фамилия",
              keyboardType: TextInputType.name,
              onChanged: (String value) {
                _userBuilder.lastName = value;
              },
              formatter: [
                FilteringTextInputFormatter.deny(RegExp(' ')),
              ],
              validator: (String value) {
                if (value.isEmpty) return '';
                return null;
              },
            ),
            SizedBox(height: boxHeight),
            GradientTextField(
              width: fieldWidth,
              height: fieldHeight,
              hintText: "Телефон",
              keyboardType: TextInputType.phone,
              formatter: [
                FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
              ],
              onChanged: (String value) {
                _userBuilder.phone = value;
              },
              validator: (String value) {
                if (value.isEmpty) return '';
                return null;
              },
            ),
            SizedBox(height: boxHeight),
            GradientTextField(
              width: fieldWidth,
              height: fieldHeight,
              hintText: "Электронная почта",
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                _userBuilder.email = value;
              },
              formatter: [
                FilteringTextInputFormatter.deny(RegExp(' ')),
              ],
              validator: (value) {
                if (value.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                  return '';
                }
                return null;
              },
            ),
            SizedBox(height: 32.0),
            GradientButton(
              maxWidth: 280.0,
              minHeight: 50.0,
              borderRadius: 10.0,
              title: "Далее",
              onTap: () {
                if (_formKey.currentState.validate()) {
                  _startSignUp();
                }
              },
            ),
            if (_showHelp == true) ...[
              SizedBox(height: 20.0),
              SwitchAuthWidget(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildThirdPage() {
    return Padding(
      padding: _itemPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextInfo(
            title: "Введите код, который мы отправили "
                "на указанный вами номер телефона",
          ),
          SizedBox(height: 20.0),
          OTPField(
            length: 6,
            width: 280.0,
            fieldWidth: 35.0,
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.white,
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            keyboardType: TextInputType.phone,
            onCompleted: (pin) {
              print("Completed: " + pin);
              _signUpNotifier.smsPin = pin;
            },
          ),
          SizedBox(height: 40.0),
          GradientButton(
            title: "Регистрация",
            maxWidth: 280.0,
            minHeight: 50.0,
            borderRadius: 10.0,
            onTap: () {
              _signUpNotifier.enterWithCredential(context: context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _signUpNotifier = Provider.of<AuthSignUpNotifier>(context);
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
            SizedBox(height: 40.0),
            ExpandablePageView(
              pageController: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (int index) {
                setState(() => _pageIndex = index);
              },
              children: [
                _buildFirstPage(),
                _buildSecondPage(),
                _buildThirdPage(),
              ],
            ),
          ],
        ),
        if (_signUpNotifier.startLoading == true) WaveIndicator(),
      ],
    );
  }
}
