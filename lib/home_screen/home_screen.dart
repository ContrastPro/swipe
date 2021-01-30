import 'package:flutter/material.dart';
import 'package:swipe/authentication_screen/api/authentication_api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              AuthenticationAPI.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
