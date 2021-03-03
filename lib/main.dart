import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/app_style.dart';
import 'package:swipe/global/map_notifier.dart';
import 'package:swipe/screens/auth_screen/auth_screen.dart';
import 'package:swipe/screens/auth_screen/provider/auth_mode_provider.dart';
import 'package:swipe/screens/banned_screen/banned_screen.dart';
import 'package:swipe/screens/home_screen/provider/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserNotifier(),
        ),
        StreamProvider<ConnectivityResult>(
          create: (_) => Connectivity().onConnectivityChanged,
        ),
        ChangeNotifierProvider(
          create: (_) => MapNotifier(),
        ),
      ],
      child: SwipeApp(),
    ),
  );
}

class SwipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru', 'RU'),
      ],
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
                  return BannedScreen(
                    userUID: snapshot.data.uid,
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold();
                }
                return ChangeNotifierProvider<AuthModeNotifier>(
                  create: (_) => AuthModeNotifier(),
                  child: AuthScreen(),
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
