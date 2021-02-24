import 'package:flutter/material.dart';

class ModalBottomSheetChat extends StatelessWidget {
  final VoidCallback deleteFromMe;
  final VoidCallback deleteEverywhere;

  const ModalBottomSheetChat({
    Key key,
    @required this.deleteFromMe,
    @required this.deleteEverywhere,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.person_outline_rounded),
          title: Text("Удалить у меня"),
          onTap: () {
            Navigator.pop(context);
            deleteFromMe();
          },
        ),
        ListTile(
          leading: Icon(Icons.people_outline_rounded),
          title: Text("Удалить у всех"),
          onTap: () {
            Navigator.pop(context);
            deleteEverywhere();
          },
        ),
      ],
    );
  }
}
