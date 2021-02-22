import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/fab/home_gradient_fab.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/filter_screen/filter_list.dart';

import 'drawer.dart';
import 'home_apartment_list_widget.dart';
import 'home_map_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  static const int _duration = 300;
  bool _isMapWidget = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildScreen() {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: _duration),
          child: _isMapWidget ? HomeMapWidget() : HomeApartmentListWidget(),
        ),
        FilterList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
          });
        },
        onRightTap: () {
          setState(() {
            _isMapWidget = true;
          });
        },
      ),
    );
  }
}
