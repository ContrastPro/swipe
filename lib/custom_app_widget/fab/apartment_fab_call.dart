import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class ApartmentFABCall extends StatelessWidget {
  static const double width = 160.0;
  static const double height = 56.0;

  final String title;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const ApartmentFABCall({
    Key key,
    this.title,
    @required this.onLeftTap,
    @required this.onRightTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration active = BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: Color(0xFFEDF9F5),
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.0),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => onLeftTap(),
            child: Container(
              width: height,
              height: height,
              decoration: active,
              child: Icon(
                Icons.phone_in_talk_rounded,
                color: AppColors.accentColor,
                size: 25.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onRightTap(),
            child: Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Color(0xFFEDF9F5).withOpacity(0.2),
              ),
              child: Icon(
                Icons.message_rounded,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
