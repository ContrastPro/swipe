import 'package:flutter/material.dart';
import 'package:swipe/screens/home_screen/custom_widget/home_product_list_widget.dart';
import 'package:swipe/screens/home_screen/custom_widget/drawer.dart';
import 'package:swipe/screens/home_screen/custom_widget/filter.dart';
import 'package:swipe/screens/home_screen/custom_widget/gradient_fab.dart';
import 'package:swipe/screens/home_screen/custom_widget/home_map_widget.dart';

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


  Widget _home() {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: _duration),
          child: _isMapWidget ? HomeMapWidget() : HomeProductListWidget(),
        ),
        Filter(),
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
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          )
        ],
      ),
      body: _home(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GradientFAB(
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
