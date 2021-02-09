import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class GradientFAB extends StatelessWidget {
  final double width = 200.0;
  final double height = 56.0;
  final String title;
  final bool value;
  final int duration;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const GradientFAB({
    Key key,
    this.title = "Title",
    @required this.value,
    this.duration = 800,
    @required this.onLeftTap,
    @required this.onRightTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration active = BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: Colors.white,
    );

    BoxDecoration inactive = BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      gradient: AppColors.buttonGradient,
    );

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        gradient: AppColors.buttonGradient,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOutCubic,
            left: value ? width - height : 0.0,
            right: value ? 0.0 : width - height,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: duration),
              child: value
                  ? GestureDetector(
                      key: UniqueKey(),
                      onTap: () => onLeftTap(),
                      child: Container(
                        width: height,
                        height: height,
                        decoration: value ? active : inactive,
                      ),
                    )
                  : GestureDetector(
                      key: UniqueKey(),
                      onTap: () => onRightTap(),
                      child: Container(
                        width: height,
                        height: height,
                        decoration: value ? inactive : active,
                      ),
                    ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
