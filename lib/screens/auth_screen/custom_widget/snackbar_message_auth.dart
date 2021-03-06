import 'package:flutter/material.dart';

class SnackBarMessageAuth {
  SnackBarMessageAuth._();

  static showSnackBar({
    @required BuildContext context,
    @required String content,
    String action,
    VoidCallback onPressed,
  }) {
    if (onPressed != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(content),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: action,
            onPressed: () => onPressed(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(content),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
