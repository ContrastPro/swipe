import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/screens/banned_screen/banned_screen.dart';
import 'package:swipe/screens/home_screen/custom_widget/home_widget.dart';
import 'api/home_firestore_api.dart';
import 'provider/user_provider.dart';

class HomeScreen extends StatelessWidget {
  final String userUID;

  const HomeScreen({
    Key key,
    this.userUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserBuilder>(
      stream: HomeFirestoreAPI.streamUser(
        userNotifier: Provider.of<UserNotifier>(context, listen: false),
        userUID: userUID ?? AuthFirebaseAPI.getCurrentUser().uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isBanned != true) {
            return HomeWidget();
          } else {
            return BannedScreen();
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
