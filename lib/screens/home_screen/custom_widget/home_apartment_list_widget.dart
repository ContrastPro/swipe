import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/home_screen/api/home_firestore_api.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/apartment_item.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/apartment_complex_item.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/apartment_item_big.dart';

class HomeApartmentListWidget extends StatelessWidget {
  Widget _buildAds(DocumentSnapshot document) {
    /*if (document["promotion"]["adWeight"] == 0) {
      // Будет дрогой тип Квартиры
      return ApartmentComplexItem(
        apartmentBuilder: ApartmentBuilder.fromMap(
          document.data(),
        ),
        onTap: () {},
      );
    }*/
    if (document["promotion"]["isBigAd"] == true) {
      return ApartmentItemBig(
        apartmentBuilder: ApartmentBuilder.fromMap(
          document.data(),
        ),
        onTap: () {},
      );
    } else {
      return ApartmentItem(
        apartmentBuilder: ApartmentBuilder.fromMap(
          document.data(),
        ),
        onTap: () {},
      );
    }
  }

  StaggeredTile _buildStaggeredTile(DocumentSnapshot document) {
    if (document["promotion"]["isBigAd"] == true) {
      return StaggeredTile.count(4, 2.8);
    } else {
      return StaggeredTile.count(2, 2.6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: HomeFirestoreAPI.getAds(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.hasData) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 100.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildAds(snapshot.data.docs[index]);
              },
              staggeredTileBuilder: (int index) {
                return _buildStaggeredTile(snapshot.data.docs[index]);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
