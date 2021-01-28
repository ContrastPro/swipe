import 'package:flutter/material.dart';
import 'package:swipe/authentication_screen/custom_widget/switch_auth_widget.dart';
import 'package:swipe/custom_app_widget/app_logo_widget.dart';
import 'package:swipe/custom_app_widget/one_time_password_widget.dart';
import 'package:swipe/global/app_colors.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  int _pageIndex = 0;
  PageController _pageController;
  Duration _duration;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true);
    _duration = Duration(milliseconds: 400);
    super.initState();
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

  Widget _buildButton({String title}) {
    return RaisedButton(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        switch (_pageIndex) {
          case 0:
            setState(() => _pageIndex++);
            _pageController.animateToPage(
              1,
              duration: _duration,
              curve: Curves.ease,
            );
            break;
          case 1:
            setState(() => _pageIndex++);
            _pageController.animateToPage(
              2,
              duration: _duration,
              curve: Curves.ease,
            );
            break;
          case 2:
            setState(() => _pageIndex++);
            break;
        }
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: AppColors.buttonGradient,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 280.0,
            minHeight: 50.0,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
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
        _buildButton(title: "Войти"),
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
          width: 280,
          height: 50,
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
              //controller: _searchController,
              onChanged: (String value) {},
            ),
          ),
        ),
        SizedBox(height: 22.0),
        _buildButton(title: "Далее"),
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
          length: 4,
          width: 250.0,
          fieldWidth: 45.0,
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.white,
          ),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.underline,
          onCompleted: (pin) {
            print("Completed: " + pin);
          },
        ),
        SizedBox(height: 40.0),
        _buildButton(title: "Войти"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppLogo(width: 70.0, height: 45.0, fontSize: 55.0),
        Container(
          height: 300,
          child: PageView(
            controller: _pageController,
            //physics: NeverScrollableScrollPhysics(),
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
    );
  }
}
