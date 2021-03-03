import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/screens/home_screen/api/home_firestore_api.dart';
import 'package:swipe/screens/home_screen/home_screen.dart';
import 'package:swipe/screens/home_screen/provider/user_provider.dart';

class BannedScreen extends StatelessWidget {
  final String userUID;

  const BannedScreen({
    Key key,
    @required this.userUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    return StreamBuilder<UserBuilder>(
      stream: HomeFirestoreAPI.streamUser(
        userNotifier: userNotifier,
        userUID: userUID,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && userNotifier.isHomeScreen != null) {
          if (snapshot.data.isBanned != true) {
            return HomeScreen();
          } else {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.backgroundGradient,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppLogo(width: 65.0, height: 40.0, fontSize: 50.0),
                    SizedBox(height: 60.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Ваш аккаунт временно заблокирован",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    GradientButton(
                      title: "Выйти",
                      maxWidth: 280.0,
                      minHeight: 50.0,
                      borderRadius: 10.0,
                      onTap: () => AuthFirebaseAPI.signOut(),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
