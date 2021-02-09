import 'package:flutter/material.dart';
import 'package:swipe/screens/home_screen/custom_widget/bulletin_board_widget.dart';
import 'package:swipe/screens/home_screen/custom_widget/drawer.dart';
import 'package:swipe/screens/home_screen/custom_widget/gradient_fab.dart';
import 'package:swipe/screens/home_screen/custom_widget/map_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool _isMapWidget = false;

  Widget _home() {
    final _items = List<String>.generate(10000, (i) => "Item $i");

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          child: _isMapWidget ? MapWidget() : BulletinBoardWidget(),
        ),
        Container(
          height: 30,
          child: ListView.builder(
            itemCount: _items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                child: Text('${_items[index]}'),
              );
            },
          ),
        ),
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
