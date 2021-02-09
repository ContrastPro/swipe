import 'package:flutter/material.dart';

class BulletinBoardWidget extends StatelessWidget {
  final _items = List<String>.generate(10000, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: UniqueKey(),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${_items[index]}'),
        );
      },
    );
  }
}
