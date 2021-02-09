import 'package:flutter/material.dart';

class ExpandableCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry margin;
  final ValueChanged<bool> onExpansionChanged;

  const ExpandableCard({
    Key key,
    this.title,
    this.children,
    this.margin,
    this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
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
          accentColor: Colors.black,
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(),
          ),
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
