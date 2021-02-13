import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/apartment_item.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/apartment_complex_item.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/apartment_item_big.dart';

class HomeApartmentListWidget extends StatelessWidget {
  final _items = List<String>.generate(20, (i) => "Item $i");

  final List<String> _imagesList = [
    "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80",
    "https://images.unsplash.com/photo-1554435493-93422e8220c8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80",
    "https://images.unsplash.com/photo-1503174971373-b1f69850bded?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1387&q=80",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 100.0),
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          if (_items[index] == "Item 2" || _items[index] == "Item 3") {
            return ApartmentComplexItem(
              imageUrl: _imagesList,
              onTap: () {},
            );
          } else if (_items[index] == "Item 4") {
            return ApartmentItemBig(
              imageUrl: _imagesList,
              onTap: () {},
            );
          } else {
            return ApartmentItem(
              imageUrl: _imagesList,
              onTap: () {},
            );
          }
        },
        staggeredTileBuilder: (int index) {
          if (_items[index] == "Item 4") {
            return StaggeredTile.count(4, 2.8);
          } else {
            return StaggeredTile.count(2, 2.6);
          }
        },
      ),
    );
  }
}
