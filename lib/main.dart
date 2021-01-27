import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/global/colors.dart';
import 'package:swipe/global/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColors.backgroundColor),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swipe',
      theme: AppTheme.light(),
      home: CheckConnection(),
    );
  }
}

class CheckConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
