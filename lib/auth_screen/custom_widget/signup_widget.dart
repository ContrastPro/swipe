import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/auth_screen/custom_widget/gradient_text_field.dart';
import 'package:swipe/auth_screen/custom_widget/switch_auth_widget.dart';
import 'package:swipe/auth_screen/provider/auth_signup_provider.dart';
import 'package:swipe/custom_app_widget/app_logo_widget.dart';
import 'package:swipe/custom_app_widget/expandeble_page_view.dart';
import 'package:swipe/custom_app_widget/gradient_button_widget.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/custom_app_widget/one_time_password_widget.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  int _pageIndex = 0;
  PageController _pageController;
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _emailController;
  EdgeInsets _itemPadding;
  AuthSignUpNotifier _signUpNotifier;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true);
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _itemPadding = const EdgeInsets.symmetric(horizontal: 45.0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
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

  Widget _secondPage() {
    double height = 14.0;
    return Padding(
      padding: _itemPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientTextField(
            width: 280.0,
            height: 50.0,
            hintText: "Имя",
            keyboardType: TextInputType.name,
            controller: _nameController,
          ),
          SizedBox(height: height),
          GradientTextField(
            width: 280.0,
            height: 50.0,
            hintText: "Телефон",
            keyboardType: TextInputType.phone,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
            ],
            controller: _phoneController,
          ),
          SizedBox(height: height),
          GradientTextField(
            width: 280.0,
            height: 50.0,
            hintText: "Email",
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          SizedBox(height: 32.0),
          GradientButton(
            title: "Далее",
            maxWidth: 280.0,
            minHeight: 50.0,
            borderRadius: 10.0,
            onTap: () async {
              await _signUpNotifier.signUpWithPhoneNumber(
                context: context,
                firstName: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
                email: _emailController.text.trim(),
              );
              /*if (_signUpNotifier.phoneIsNotExist() == true) {
                _changePage();
              }*/
            },
          ),
        ],
      ),
    );
  }

  Widget _thirdPage() {
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
            title: "Войти",
            maxWidth: 280.0,
            minHeight: 50.0,
            borderRadius: 10.0,
            onTap: () {
              _signUpNotifier.enterWithCredential(
                context: context,
              );
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
                //_firstPage(),
                _secondPage(),
                _thirdPage(),
              ],
            ),
          ],
        ),
        if (_signUpNotifier.startLoading == true) WaveIndicator(),
        //if (_pageIndex == 1) PrivacyPolicy(),
      ],
    );
  }
}