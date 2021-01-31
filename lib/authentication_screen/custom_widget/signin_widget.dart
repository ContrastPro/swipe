import 'package:flutter/material.dart';
import 'package:swipe/authentication_screen/api/firebase_auth_api.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/custom_app_widget/notification_dialog.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/custom_app_widget/app_logo_widget.dart';
import 'package:swipe/custom_app_widget/gradient_button_widget.dart';
import 'package:swipe/custom_app_widget/one_time_password_widget.dart';
import 'package:swipe/authentication_screen/custom_widget/switch_auth_widget.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  int _pageIndex = 0;
  String _smsPin;
  bool _startLoading = false;
  PageController _pageController;
  TextEditingController _phoneController;
  AuthAPI _authenticationAPI;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true);
    _phoneController = TextEditingController();
    _authenticationAPI = AuthAPI();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  /// Methods

  void _changePage() {
    setState(() => _pageIndex++);
    _pageController.animateToPage(
      _pageIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  void _showDialog(String content) {
    showDialog(
      context: context,
      builder: (context) {
        return NotificationDialog(
          title: 'Упс...',
          content: _authenticationAPI.message,
        );
      },
    );
  }

  void _verifyPhoneNumber(String phone) async {
    // Test phone: +44 7123 123456
    FocusScope.of(context).unfocus();
    setState(() => _startLoading = true);
    await _authenticationAPI.verifyPhoneNumber(phone: phone);
    if (_authenticationAPI.status == AuthStatus.EXIST) {
      _changePage();
    } else if (_authenticationAPI.status == AuthStatus.NOTEXIST) {
      _showDialog(_authenticationAPI.message);
    }
    setState(() => _startLoading = false);
  }

  void _signInWithPhoneNumber() async {
    if (_smsPin.length == 6) {
      setState(() => _startLoading = true);
      await _authenticationAPI.signInWithPhoneNumber(smsCode: _smsPin);
      if (_authenticationAPI.status == AuthStatus.ERROR) {
        setState(() => _startLoading = false);
        _showDialog(_authenticationAPI.message);
      }
    }
  }

  /// Widgets

  Widget _buildTextInfo({String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
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

  Widget _firstPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTextInfo(
          title: "Открой доступ к самой полной базе рынка квартир в Сочи!",
        ),
        SizedBox(height: 55.0),
        GradientButton(
          title: "Войти",
          maxWidth: 280.0,
          minHeight: 50.0,
          borderRadius: 10.0,
          onTap: () => _changePage(),
        ),
        SizedBox(height: 20.0),
        SwitchAuthWidget(),
      ],
    );
  }

  Widget _secondPage() {
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 280.0,
          height: 50.0,
          decoration: BoxDecoration(
            gradient: AppColors.textFieldGradient,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Center(
            child: TextField(
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                enabledBorder: border,
                disabledBorder: border,
                focusedBorder: border,
                border: border,
                hintText: 'Телефон',
                hintStyle: TextStyle(color: Colors.white),
              ),
              controller: _phoneController,
            ),
          ),
        ),
        SizedBox(height: 22.0),
        GradientButton(
          title: "Далее",
          maxWidth: 280.0,
          minHeight: 50.0,
          borderRadius: 10.0,
          onTap: () {
            _verifyPhoneNumber(_phoneController.text.trim());
          },
        ),
      ],
    );
  }

  Widget _thirdPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTextInfo(
          title: "Введите код, который мы отправили "
              "на указанный вами номер телефона",
        ),
        SizedBox(height: 20.0),
        OTPField(
          length: 6,
          width: 270.0,
          fieldWidth: 30.0,
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.white,
          ),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.underline,
          onCompleted: (pin) {
            print("Completed: " + pin);
            setState(() => _smsPin = pin);
          },
        ),
        SizedBox(height: 40.0),
        GradientButton(
          title: "Войти",
          maxWidth: 280.0,
          minHeight: 50.0,
          borderRadius: 10.0,
          onTap: () => _signInWithPhoneNumber(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
              Container(
                height: 300,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (int index) {
                    setState(() => _pageIndex = index);
                  },
                  children: <Widget>[
                    _firstPage(),
                    _secondPage(),
                    _thirdPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_startLoading == true) WaveIndicator(),
      ],
    );
  }
}
