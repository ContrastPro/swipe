import 'package:flutter/material.dart';
import 'package:swipe/global/style/app_colors.dart';

class AppBarStyle3 extends PreferredSize {
  final String title;
  final Color backgroundColor;
  final VoidCallback onTapLeading;
  final VoidCallback onTapAction;

  const AppBarStyle3({
    Key key,
    this.title,
    this.backgroundColor,
    @required this.onTapLeading,
    @required this.onTapAction,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Color splashColor = Colors.transparent;

    return SafeArea(
      child: Container(
        height: preferredSize.height,
        color: backgroundColor ?? AppColors.primaryColor,
        child: Row(
          children: [
            IconButton(
              highlightColor: splashColor,
              splashColor: splashColor,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black.withAlpha(160),
                size: 18.0,
              ),
              onPressed: () => onTapLeading(),
            ),
            Expanded(
              child: Text(
                title ?? "Title",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            IconButton(
              highlightColor: splashColor,
              splashColor: splashColor,
              icon: Icon(
                Icons.phone_rounded,
                color: AppColors.accentColor,
                size: 28.0,
              ),
              onPressed: () => onTapAction(),
            ),
            SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}