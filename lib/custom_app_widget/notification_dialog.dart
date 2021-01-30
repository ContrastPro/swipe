import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final String title;
  final String content;

  const NotificationDialog({
    Key key,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title ?? "Title"),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
      children: [
        Text(
          content ?? "Content",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
