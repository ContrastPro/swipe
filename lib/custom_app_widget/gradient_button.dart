import 'package:flutter/material.dart';
import 'package:swipe/global/style/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final double maxWidth;
  final double minHeight;
  final double borderRadius;
  final double elevation;
  final double highlightElevation;
  final TextStyle style;
  final VoidCallback onTap;

  const GradientButton({
    Key key,
    this.title,
    this.maxWidth,
    this.minHeight,
    this.borderRadius,
    this.elevation,
    this.highlightElevation,
    this.style,
    @required this.onTap,
  }) : assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: elevation ?? 1.0,
      highlightElevation: highlightElevation ?? 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
      ),
      padding: EdgeInsets.all(0.0),
      onPressed: () => onTap(),
      child: Ink(
        decoration: BoxDecoration(
          gradient: AppColors.buttonGradient,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? 280.0,
            minHeight: minHeight ?? 50.0,
          ),
          alignment: Alignment.center,
          child: Text(
            title ?? "Button",
            textAlign: TextAlign.center,
            style: style ??
                TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}