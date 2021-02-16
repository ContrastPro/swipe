import 'package:flutter/material.dart';

class HomeMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      key: UniqueKey(),
      child: Image.asset(
        "assets/images/map.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
