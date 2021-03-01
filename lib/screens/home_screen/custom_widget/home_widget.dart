import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/fab/home_gradient_fab.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_ads.dart';
import 'package:swipe/global/map_notifier.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/filter_screen/filter_list.dart';
import 'package:swipe/screens/home_screen/api/home_firestore_api.dart';

import '../home_screen.dart';
import 'drawer.dart';
import 'home_apartment_list_widget.dart';
import 'home_map_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with AutomaticKeepAliveClientMixin {
  // Keep State
  @override
  bool get wantKeepAlive => true;

  static const int _duration = 400;
  int _currentIndex = 0;
  bool _isMapWidget = false;

  @override
  void initState() {
    Provider.of<MapNotifier>(context, listen: false)..mapInitialize();
    super.initState();
  }

  List<ApartmentBuilder> _convertList(List<DocumentSnapshot> documentList) {
    return documentList.map<ApartmentBuilder>((element) {
      return ApartmentBuilder.fromMap(
        element.data(),
      );
    }).toList();
  }

  Widget _buildScreen() {
    return StreamBuilder<QuerySnapshot>(
      stream: HomeFirestoreAPI.getAds(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        if (!snapshot.hasData) {
          return ShimmerAds();
        }

        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          List<ApartmentBuilder> apartmentList =
              _convertList(snapshot.data.docs);

          if (apartmentList.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  Duration(milliseconds: 800),
                ).then((value) {
                  return Navigator.pushAndRemoveUntil(
                      context, FadeRoute(page: HomeScreen()), (route) => false);
                });
              },
              child: Stack(
                children: [
                  IndexedStack(
                    index: _currentIndex,
                    children: [
                      HomeApartmentListWidget(
                        documentList: snapshot.data.docs,
                        apartmentList: apartmentList,
                      ),
                      HomeMapWidget(
                        documentList: snapshot.data.docs,
                        apartmentList: apartmentList,
                      ),
                    ],
                  ),
                  FilterList(),
                ],
              ),
            );
          }
        }
        return Center(
          child: Text("Здесь пока ничего нет..."),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: GradientDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.tune,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  "Уточнить поиск",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20.0),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(
                  Icons.favorite_border,
                  color: Colors.black54,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Избранное",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: NetworkConnectivity(
        child: _buildScreen(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HomeGradientFAB(
        value: _isMapWidget,
        duration: _duration,
        title: _isMapWidget ? "Карта" : "Лента",
        onLeftTap: () {
          setState(() {
            _isMapWidget = false;
            _currentIndex = 0;
          });
        },
        onRightTap: () {
          setState(() {
            _isMapWidget = true;
            _currentIndex = 1;
          });
        },
      ),
    );
  }
}
