import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class HomeGradientFAB extends StatelessWidget {
  static const double width = 220.0;
  static const double height = 56.0;

  final String title;
  final bool value;
  final int duration;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const HomeGradientFAB({
    Key key,
    this.title,
    @required this.duration,
    @required this.value,
    @required this.onLeftTap,
    @required this.onRightTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration active = BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: Color(0xFFEDF9F5),
    );

    Widget _iconButton({
      BoxDecoration decoration,
      double opacity,
      Icon activeIcon,
      Icon inactiveIcon,
    }) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.2,
            child: Container(
              width: height,
              height: height,
              decoration: active,
            ),
          ),
          inactiveIcon,
          AnimatedOpacity(
            duration: Duration(milliseconds: duration),
            opacity: opacity,
            child: Container(
              width: height,
              height: height,
              decoration: active,
              child: activeIcon,
            ),
          ),
        ],
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => onLeftTap(),
              child: _iconButton(
                decoration: active,
                opacity: value ? 0 : 1,
                activeIcon: Icon(
                  Icons.menu_rounded,
                  color: AppColors.accentColor,
                ),
                inactiveIcon: Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => onRightTap(),
              child: _iconButton(
                decoration: active,
                opacity: value ? 1 : 0,
                activeIcon: Icon(
                  Icons.map_outlined,
                  color: AppColors.accentColor,
                ),
                inactiveIcon: Icon(
                  Icons.map_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
