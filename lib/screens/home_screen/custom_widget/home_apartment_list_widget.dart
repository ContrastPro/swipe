import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swipe/model/apartment.dart';

import 'items_list_widget/apartment_item.dart';
import 'items_list_widget/apartment_item_big.dart';

class HomeApartmentListWidget extends StatelessWidget {
  final List<DocumentSnapshot> documentList;
  final List<ApartmentBuilder> apartmentList;

  const HomeApartmentListWidget({
    Key key,
    @required this.documentList,
    @required this.apartmentList,
  }) : super(key: key);

  Widget _buildAds(int index, ApartmentBuilder apartment) {
    /*if (document["promotion"]["isBigAd"] == null) {
      // Будет дрогой тип Квартиры
      return ApartmentComplexItem(
        apartmentBuilder: ApartmentBuilder.fromMap(
          document.data(),
        ),
        onTap: () {},
      );
    }*/
    if (apartment.promotionBuilder.isBigAd == true) {
      return ApartmentItemBig(
        apartmentBuilder: apartment,
        documentSnapshot: documentList[index],
        onTap: () {},
      );
    } else {
      return ApartmentItem(
        apartmentBuilder: apartment,
        documentSnapshot: documentList[index],
        onTap: () {},
      );
    }
  }

  StaggeredTile _buildStaggeredTile(ApartmentBuilder apartment) {
    if (apartment.promotionBuilder.isBigAd) {
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
          return _buildAds(index, apartmentList[index]);
        },
        staggeredTileBuilder: (int index) {
          return _buildStaggeredTile(apartmentList[index]);
        },
      ),
    );
  }
}
