import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class GradientButton extends StatefulWidget {
  final String title;
  final double maxWidth;
  final double minHeight;
  final double borderRadius;
  final TextStyle style;
  final VoidCallback onTap;

  const GradientButton({
    Key key,
    this.title,
    this.maxWidth,
    this.minHeight,
    this.borderRadius,
    this.style,
    @required this.onTap,
  }) : assert(onTap != null);

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
      ),
      padding: EdgeInsets.all(0.0),
      onPressed: () => widget.onTap(),
      child: Ink(
        decoration: BoxDecoration(
          gradient: AppColors.buttonGradient,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth ?? 280.0,
            minHeight: widget.minHeight ?? 50.0,
          ),
          alignment: Alignment.center,
          child: Text(
            widget.title ?? "Button",
            textAlign: TextAlign.center,
            style: widget.style ??
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
