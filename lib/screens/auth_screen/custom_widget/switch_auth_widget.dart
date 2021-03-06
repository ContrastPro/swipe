import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/screens/auth_screen/provider/auth_mode_provider.dart';



class SwitchAuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModeNotifier>(
      builder: (context, authNotifier, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                authNotifier.authMode == AuthMode.SIGNIN
                    ? "Впервые у нас?"
                    : "Уже есть аккаунт?",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
              SizedBox(width: 10.0),
              InkWell(
                onTap: () => authNotifier.changeAuthMode(),
                child: Text(
                  authNotifier.authMode == AuthMode.SIGNIN
                      ? "Регистрация"
                      : "Войти",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
