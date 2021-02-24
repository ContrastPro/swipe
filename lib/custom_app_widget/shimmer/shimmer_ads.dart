import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAds extends StatelessWidget {
  static const Color _color = Colors.white24;

  @override
  Widget build(BuildContext context) {
    Widget buildFilter() {
      return Shimmer.fromColors(
        baseColor: Colors.grey[350],
        highlightColor: Colors.grey[600],
        child: Container(
          width: 100,
          margin: const EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: _color,
          ),
        ),
      );
    }

    Widget buildItem() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: _color,
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                margin: const EdgeInsets.only(right: 30.0),
                height: 18.0,
                color: _color,
              ),
              SizedBox(height: 5.0),
              Container(
                height: 12.0,
                color: _color,
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          height: 42,
          padding: const EdgeInsets.only(left: 8.0, top: 10.0),
          child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return buildFilter();
            },
          ),
        ),
        ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 50.0),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[350],
              highlightColor: Colors.grey[600],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildItem(),
                  buildItem(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
