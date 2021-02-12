import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/product_list_item_style_1.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/product_list_item_style_2.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/product_list_item_style_3.dart';

class HomeProductListWidget extends StatelessWidget {
  final _items = List<String>.generate(20, (i) => "Item $i");
  final String image1 = "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80";
  final String image2 = "https://images.unsplash.com/photo-1554435493-93422e8220c8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=676&q=80";
  final String image3 = "https://images.unsplash.com/photo-1503174971373-b1f69850bded?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1387&q=80";

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
            return ProductItemIStyle2(
              imageUrl: image2,
              onTap: () {},
            );
          } else if (_items[index] == "Item 4") {
            return ProductItemIStyle3(
              imageUrl: image3,
              onTap: () {},
            );
          } else {
            return ProductItemIStyle1(
              imageUrl: image1,
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
