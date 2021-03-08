import 'package:flutter/material.dart';
import 'package:swipe/global/style/app_colors.dart';

class AppBarStyle2 extends PreferredSize {
  final List<Widget> actions;
  final Color backgroundColor;

  const AppBarStyle2({
    Key key,
    this.actions,
    this.backgroundColor,
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
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          children: [
            IconButton(
              highlightColor: splashColor,
              splashColor: splashColor,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black.withAlpha(160),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
