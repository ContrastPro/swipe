import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class ApartmentFABEdit extends StatelessWidget {
  static const double width = 220.0;
  static const double height = 56.0;

  final String title;
  final VoidCallback onTap;

  const ApartmentFABEdit({
    Key key,
   this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        gradient: AppColors.buttonGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2.0,
            blurRadius: 2.0,
            offset: Offset(1, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        title ?? "Title",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
