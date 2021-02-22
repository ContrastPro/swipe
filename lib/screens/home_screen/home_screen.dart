import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/home_firestore_api.dart';
import 'custom_widget/home_widget.dart';
import 'provider/user_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeFirestoreAPI.getUserProfile(
        userNotifier: Provider.of<UserNotifier>(context, listen: false),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return HomeWidget();
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
