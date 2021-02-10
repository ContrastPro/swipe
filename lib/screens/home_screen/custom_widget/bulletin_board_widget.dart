import 'package:flutter/material.dart';

class BulletinBoardWidget extends StatelessWidget {
  final _items = List<String>.generate(10000, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_items[index]}'),
          );
        },
      ),
    );
  }
}
