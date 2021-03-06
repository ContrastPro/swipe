import 'package:flutter/material.dart';

class SignUpIconSignUp extends StatelessWidget {
  final String iconPath;
  final String title;
  final double width;
  final double height;
  final VoidCallback onTap;

  const SignUpIconSignUp({
    Key key,
    @required this.iconPath,
    @required this.title,
    @required this.width,
    @required this.height,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 5.0),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
