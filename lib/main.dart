import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/auth_screen/auth_screen.dart';
import 'package:swipe/auth_screen/provider/auth_mode_provider.dart';
import 'package:swipe/global/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swipe/home_screen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(SwipeApp());
}

class SwipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swipe',
      theme: AppTheme.light(),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<User>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  return HomeScreen();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold();
                }
                return ChangeNotifierProvider<AuthModeNotifier>(
                  create: (_) => AuthModeNotifier(),
                  child: AuthenticationScreen(),
                );
              },
            );
          }

          return Scaffold();
        },
      ),
    );
  }
}
