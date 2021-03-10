import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/global/firebase_api.dart';
import 'package:swipe/screens/banned_screen/banned_screen.dart';
import 'package:swipe/screens/home_screen/custom_widget/home_widget.dart';

import 'api/home_firestore_api.dart';
import 'provider/user_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserBuilder>(
      stream: HomeFirestoreAPI.streamUser(
        userNotifier: Provider.of<UserNotifier>(context, listen: false),
        userUID: FirebaseAPI.currentUser().uid,
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
