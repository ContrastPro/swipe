import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';

class PromotionScreen extends StatefulWidget {
  final ApartmentBuilder apartmentBuilder;
  final List<String> imageList;

  const PromotionScreen({
    Key key,
    this.apartmentBuilder,
    this.imageList,
  }) : super(key: key);

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Продвижение",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: NetworkConnectivity(
        child: Container(),
      ),
    );
  }
}
