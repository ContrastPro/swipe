import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swipe/model/apartment.dart';

import 'items_list_widget/apartment_item.dart';
import 'items_list_widget/apartment_item_big.dart';

class HomeApartmentListWidget extends StatelessWidget {
  final List<ApartmentBuilder> apartmentList;

  const HomeApartmentListWidget({
    Key key,
    @required this.apartmentList,
  }) : super(key: key);

  Widget _buildAds(ApartmentBuilder apartmentBuilder) {
    /*if (document["promotion"]["isBigAd"] == null) {
      // Будет дрогой тип Квартиры
      return ApartmentComplexItem(
        apartmentBuilder: ApartmentBuilder.fromMap(
          document.data(),
        ),
        onTap: () {},
      );
    }*/
    if (apartmentBuilder.promotionBuilder.isBigAd == true) {
      return ApartmentItemBig(
        apartmentBuilder: apartmentBuilder,
        onTap: () {},
      );
    } else {
      return ApartmentItem(
        apartmentBuilder: apartmentBuilder,
        onTap: () {},
      );
    }
  }

  StaggeredTile _buildStaggeredTile(ApartmentBuilder apartmentBuilder) {
    if (apartmentBuilder.promotionBuilder.isBigAd) {
      return StaggeredTile.count(4, 2.8);
    } else {
      return StaggeredTile.count(2, 2.6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 100.0),
        itemCount: apartmentList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildAds(apartmentList[index]);
        },
        staggeredTileBuilder: (int index) {
          return _buildStaggeredTile(apartmentList[index]);
        },
      ),
    );
  }
}
