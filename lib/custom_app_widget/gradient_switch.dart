import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class GradientSwitch extends StatelessWidget {
  final double width;
  final double height;
  final bool value;
  final int duration;
  final ValueChanged<bool> onChanged;

  const GradientSwitch({
    Key key,
    this.width = 45.0,
    this.height = 28.0,
    @required this.value,
    this.duration = 700,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration activeBackground = BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF27AE60).withAlpha(80),
          Color(0xFF27AEA6).withAlpha(80),
        ],
      ),
    );

    BoxDecoration inactiveBackground = BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: Colors.black.withAlpha(40),
    );

    BoxDecoration activeForeground = BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      gradient: AppColors.buttonGradient,
    );

    BoxDecoration inactiveForeground = BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: Colors.black.withAlpha(60),
    );

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: duration),
            child: value
                ? Container(
                    key: UniqueKey(),
                    width: width,
                    height: height,
                    decoration: activeBackground,
                  )
                : Container(
                    key: UniqueKey(),
                    width: width,
                    height: height,
                    decoration: inactiveBackground,
                  ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOutCubic,
            left: value ? height / 2 : 0.0,
            right: value ? 0.0 : height / 2,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: duration),
              child: value
                  ? Container(
                      key: UniqueKey(),
                      width: height,
                      height: height,
                      decoration: activeForeground,
                    )
                  : Container(
                      key: UniqueKey(),
                      width: height,
                      height: height,
                      decoration: inactiveForeground,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
