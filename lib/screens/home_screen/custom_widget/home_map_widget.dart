import 'package:flutter/material.dart';
import 'package:swipe/model/apartment.dart';

class HomeMapWidget extends StatelessWidget {
  final List<ApartmentBuilder> apartmentList;

  const HomeMapWidget({
    Key key,
    this.apartmentList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "assets/images/map.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
