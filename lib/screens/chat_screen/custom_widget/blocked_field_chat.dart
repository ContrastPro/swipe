import 'package:flutter/material.dart';

class BlockedFieldChat extends StatelessWidget {
  final String username;

  const BlockedFieldChat({
    Key key,
    @required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              "Ва не можете отправлять сообщения $username. "
                  "Пользователь был заблокирован",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
