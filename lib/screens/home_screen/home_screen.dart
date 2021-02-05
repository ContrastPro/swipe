import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/screens/home_screen/custom_widget/drawer.dart';
import 'package:swipe/screens/home_screen/provider/user_notifier.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<UserNotifier>(context, listen: false)..setUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GradientDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
