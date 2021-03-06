import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';

import 'custom_widget/first_page_signin.dart';

class SignInWidgetAuthScreen extends StatefulWidget {
  @override
  _SignInWidgetAuthScreenState createState() => _SignInWidgetAuthScreenState();
}

class _SignInWidgetAuthScreenState extends State<SignInWidgetAuthScreen> {
  final Duration _duration = Duration(milliseconds: 1000);
  final Curve _curve = Curves.easeInOutQuint;
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
            Container(color: Colors.blue),
            Container(color: Colors.green),
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
          case 1:
            _previousPage();
            return false;
          default:
            return false;
        }
      },
      child: _buildScreen(),
    );
  }
}
