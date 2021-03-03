import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/screens/admin_panel/admin_home_screen/admin_home_screen.dart';

import 'custom_widget/home_widget.dart';
import 'provider/user_provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(
      builder: (context, userNotifier, child) {
        return userNotifier.isHomeScreen ? HomeWidget() : AdminHomeScreen();
      },
    );
  }
}
