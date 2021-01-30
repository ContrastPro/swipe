import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaveIndicator extends StatelessWidget {
  final Color backgroundColor;
  final Color loadingColor;

  const WaveIndicator({
    Key key,
    this.backgroundColor,
    this.loadingColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor ?? Colors.black38,
      child: Center(
        child: SpinKitWave(
          color: loadingColor ?? Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
