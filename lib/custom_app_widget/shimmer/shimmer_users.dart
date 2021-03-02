import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUsers extends StatelessWidget {
  static const Color _color = Colors.white24;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[350],
          highlightColor: Colors.grey[600],
          child: ListTile(
            leading: CircleAvatar(backgroundColor: _color),
            title: Container(height: 14.0, color: _color),
            subtitle: Container(height: 8.0, color: _color),
          ),
        );
      },
    );
  }
}
