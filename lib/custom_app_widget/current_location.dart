import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class CurrentLocation extends StatelessWidget {
  final bool isLocated;
  final VoidCallback onTap;

  const CurrentLocation({
    Key key,
    @required this.isLocated,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 45.0,
        height: 45.0,
        margin: const EdgeInsets.only(bottom: 18.0, left: 15.0, right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: Colors.white,
        ),
        child: Icon(
          Icons.my_location,
          color: isLocated ? AppColors.accentColor : Colors.grey,
        ),
      ),
    );
  }
}
