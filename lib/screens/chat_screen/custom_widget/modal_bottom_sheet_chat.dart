import 'package:flutter/material.dart';

class ModalBottomSheetChat extends StatelessWidget {
  final String username;
  final VoidCallback onEdit;
  final VoidCallback deleteEverywhere;
  final VoidCallback deleteFromMe;
  final bool isNotOwnerMassage;

  const ModalBottomSheetChat({
    Key key,
    @required this.username,
    @required this.onEdit,
    @required this.deleteEverywhere,
    @required this.deleteFromMe,
    @required this.isNotOwnerMassage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black.withAlpha(170),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isNotOwnerMassage == true) ...[
          ListTile(
            leading: Icon(
              Icons.edit_outlined,
              color: Colors.black.withAlpha(150),
            ),
            title: Text(
              "Изменить",
              style: textStyle,
            ),
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
          ),
        ],
        ListTile(
          leading: Icon(
            Icons.people_outline_rounded,
            color: Colors.black.withAlpha(150),
          ),
          title: Text(
            "Удалить у меня и у $username",
            style: textStyle,
          ),
          onTap: () {
            Navigator.pop(context);
            deleteEverywhere();
          },
        ),
        ListTile(
          leading: Icon(
            Icons.person_outline_rounded,
            color: Colors.black.withAlpha(150),
          ),
          title: Text(
            "Удалить у меня",
            style: textStyle,
          ),
          onTap: () {
            Navigator.pop(context);
            deleteFromMe();
          },
        ),
      ],
    );
  }
}
