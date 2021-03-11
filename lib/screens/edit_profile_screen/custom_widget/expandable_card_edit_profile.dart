import 'package:flutter/material.dart';

class ExpandableCardEditProfile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final ValueChanged<bool> onExpansionChanged;

  const ExpandableCardEditProfile({
    Key key,
    this.title,
    this.children,
    this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey[200],
          width: 1.0,
        ),
      ),
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          //accentColor: Colors.black,
        ),
        child: ExpansionTile(
          title: Text(title),
          children: children,
          onExpansionChanged: (bool value) {
            if (onExpansionChanged != null) {
              onExpansionChanged(value);
            }
          },
        ),
      ),
    );
  }
}
