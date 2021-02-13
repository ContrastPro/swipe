import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int index;
  final int progressCount;
  final double width;
  final double height;
  final Color colorPrimary;
  final Color colorSecondary;

  PageIndicator({
    @required this.index,
    @required this.progressCount,
    this.width,
    this.height,
    this.colorPrimary,
    this.colorSecondary,
  });

  Widget buildProgressIndicator(BuildContext context, int i) {
    Widget progressIndicator;

    if (index == i) {
      progressIndicator = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          width: width + 2,
          height: height + 2,
          decoration: BoxDecoration(
            color: colorSecondary,
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2.5,
                blurRadius: 2.5,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
        ),
      );
    } else {
      progressIndicator = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colorPrimary,
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
        ),
      );
    }
    return progressIndicator;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        progressCount,
        (index) => buildProgressIndicator(context, index),
      ),
    );
  }
}
